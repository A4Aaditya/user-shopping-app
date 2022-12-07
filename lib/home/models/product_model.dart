class ProductModel {
  final String id;
  final String imageUrl;
  final String productName;
  final String productDescription;
  final num mrp;
  final num offerPrice;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.mrp,
    required this.offerPrice,
    required this.productDescription,
    required this.productName,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map, {String? id}) {
    return ProductModel(
      id: id ?? map['id'],
      imageUrl: map['imageUrl'],
      mrp: map['mrp'],
      offerPrice: map['offer_price'],
      productDescription: map['product_description'],
      productName: map['product_name'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'mrp': mrp,
      'offer_price': offerPrice,
      'product_description': productDescription,
      'product_name': productName,
    };
  }
}
