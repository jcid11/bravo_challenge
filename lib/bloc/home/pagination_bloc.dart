import 'dart:async';

import 'package:bravo_challenge/bloc/home/pagination_event.dart';
import 'package:bravo_challenge/bloc/home/pagination_state.dart';
import 'package:bravo_challenge/models/product_model.dart';
import 'package:bravo_challenge/service/home_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/home_interface.dart';

class BlocHome extends Bloc<HomeEvent, HomeState> {
  final HomeInterface homeService;

  BlocHome()
      : homeService = HomeService(),
        super(HomeState()) {
    _onPageRequest.stream
        .flatMap(_fetchProductList)
        .listen(_onNewListingStateController.add);
    listenPageKey();
    listenNewState();
  }

  static const _pageSize = 10;
  final PagingController<int, ProductModel> pagingController =
      PagingController(firstPageKey: 1);

  final _onNewListingStateController = BehaviorSubject<HomeState>.seeded(
    HomeState(),
  );

  Stream<HomeState> get onNewListingState =>
      _onNewListingStateController.stream;

  final _onPageRequest = StreamController<int>();

  Sink<int> get onPageRequestSink => _onPageRequest.sink;

  void listenPageKey() {
    pagingController.addPageRequestListener((pageKey) {
      onPageRequestSink.add(pageKey);
    });
  }

  void listenNewState() {
    onNewListingState.listen((listingState) {
      pagingController.value = PagingState(
        nextPageKey: listingState.nextPageKey,
        error: listingState.error,
        itemList: listingState.productList,
      );
    });
  }

  Stream<HomeState> _fetchProductList(int pageKey) async* {
    final lastListingState = _onNewListingStateController.value;
    try {
      final result =
          await homeService.getProducts(page: pageKey, pageSize: _pageSize);
      final newItems = result.data;
      final isLastPage = newItems.length < _pageSize;
      final nextPageKey = isLastPage ? null : pageKey + 1;
      yield HomeState(
        error: null,
        nextPageKey: nextPageKey,
        productList: [
          ...lastListingState.productList ?? [],
          ...newItems,
        ],
      );
    } catch (e) {
      yield HomeState(
        error: e,
        nextPageKey: lastListingState.nextPageKey,
        productList: lastListingState.productList,
      );
    }
  }

  void closeStreams() {
    _onNewListingStateController.close();
    pagingController.dispose();
    _onPageRequest.close();
  }
}
