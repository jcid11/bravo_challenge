// import 'package:bravo_challenge/service/home_service.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../data/home_interface.dart';
// import 'home_event.dart';
// import 'home_state.dart';
//
// class HomeBloc extends Bloc<HomeEvent, HomeState> {
//   final HomeInterface _homeService;
//
//   HomeBloc()
//       : _homeService = HomeService(),
//         super(const HomeState()) {
//     on<GetProductsEvent>(_getProducts);
//   }
//
//   void _getProducts(GetProductsEvent event, Emitter emit) async {
//     emit(state.copyWith(productListStatus: ProductListStatus.loading));
//     try {
//       final result = await _homeService.getProducts();
//       if (result.success) {
//         emit(state.copyWith(
//             productListStatus: ProductListStatus.success,
//             productList: result.data));
//       }
//     } catch (e) {
//       emit(state.copyWith(productListStatus: ProductListStatus.failure));
//     }
//   }
//
// }
