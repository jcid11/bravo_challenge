class ProductModel {
  final int id;
  final String name;
  final double price;
  final double tax;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.tax});

 factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['idArticulo'],
      name: json['nombreArticulo'],
      price: json['associatedPvp'],
      tax: json['impuestoArticulo']);
}
