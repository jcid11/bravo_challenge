import 'package:bravo_challenge/bloc/product/product_cubit.dart';
import 'package:bravo_challenge/bloc/product/product_state.dart';
import 'package:bravo_challenge/utils/extensions.dart';
import 'package:bravo_challenge/utils/reusable_widget/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/product_model.dart';
import '../../../utils/theme.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BuildText(text: 'Product Detail'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<ProductCubit, ProductState>(
          builder: (BuildContext context, state) {
            final ProductModel? product = state.product;
            return state.productStatus == ProductStatus.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.productStatus == ProductStatus.success
                    ? ThemeApp.appPadding(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            informationRow(
                                title: 'Name',
                                value: product!.name.toString().capitalize()),
                            informationRow(
                                title: 'Price',
                                value: product.price.toString().toPesos()),
                            informationRow(
                                title: 'Tax',
                                value: product.tax.toString().toPesos()),
                          ],
                        ),
                      )
                    : const Center(
                        child: BuildText(
                        text: 'An error has ocurred',
                      ));
          },
        ),
      ),
    );
  }
}

Widget informationRow({required String title, required String value}) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildText(
          text: '$title: ',
          color: Colors.black,
          fontSize: 16,
        ),
        BuildText(text: value)
      ],
    );
