class CartModel{
  CartModel({
    required this.productId,
    required this.quantity,
    required this.productName,
    required this.price,
    required this.comment,
    required this.inStockQTY,
    required this.productImage,
    required this.createdDate,
    required this.updatedDate,
    required this.categoryId
  });


  late int productId;
    late int quantity;
    late int inStockQTY;
  late String productName;
  late int price;
  late String comment;
  late String productImage;
  late String createdDate;
  late String updatedDate;
  late int categoryId;

}