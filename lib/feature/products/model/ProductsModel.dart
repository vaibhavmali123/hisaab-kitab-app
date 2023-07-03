class ProductsModel {
  ProductsModel({
    required this.statusCode,
    required this.message,
    required this.list,
  });
  late final String statusCode;
  late final String message;
  late final List<ProductsList> list;

  ProductsModel.fromJson(Map<String, dynamic> json){
    statusCode = json['statusCode'];
    message = json['message'];
    list = List.from(json['list']).map((e)=>ProductsList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['list'] = list.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ProductsList {
  ProductsList({
    required this.productId,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.comment,
    required this.productImage,
    required this.createdDate,
    required this.updatedDate,
    required this.categoryId,
    required this.subCategoryId,
  });
  late final int productId;
  late final String productName;
  late final int price;
  late final int quantity;
  late final String comment;
  late final String productImage;
  late final String createdDate;
  late final String updatedDate;
  late final int categoryId;
  late final int subCategoryId;

  ProductsList.fromJson(Map<String, dynamic> json){
    productId = json['productId'];
    productName = json['productName'];
    price = json['price'];
    quantity = json['quantity'];
    comment = json['comment']==null?"":json['comment'];
    productImage = json['productImage']==null?"":json['productImage'];
    createdDate = json['createdDate']==null?"":json['createdDate'];
    updatedDate = json['updatedDate']==null?"":json['updatedDate'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId']==null?json['subCategoryId']:json['subCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productId'] = productId;
    _data['productName'] = productName;
    _data['price'] = price;
    _data['quantity'] = quantity;
    _data['comment'] = comment==null?"":comment;
    _data['productImage'] = productImage==null?"":productImage;
    _data['createdDate'] = createdDate;
    _data['updatedDate'] = updatedDate;
    _data['categoryId'] = categoryId;
    _data['subCategoryId'] = subCategoryId==null?0:subCategoryId;
    return _data;
  }
}