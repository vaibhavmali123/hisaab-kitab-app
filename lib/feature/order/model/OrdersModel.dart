class OrdersModel {
  OrdersModel({
    required this.statusCode,
    required this.message,
    required this.list,
  });
  late final String statusCode;
  late final String message;
  late final List<OrderItem> list;

  OrdersModel.fromJson(Map<String, dynamic> json){
    statusCode = json['statusCode'];
    message = json['message'];
    list = List.from(json['list']).map((e)=>OrderItem.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['list'] = list.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class OrderItem {
  OrderItem({
    required this.orderId,
    required this.date,
    required this.status,
    required this.customer,
    this.productsResponseDTO,
  });
  late final int orderId;
  late final String date;
  late final String status;
  late final Customer customer;
  late final ProductsResponseDTO? productsResponseDTO;

  OrderItem.fromJson(Map<String, dynamic> json){
    orderId = json['orderId'];
    date = json['date'];
    status = json['status'];
    customer = Customer.fromJson(json['customer']);
    productsResponseDTO = ProductsResponseDTO.fromJson(json['productsResponseDTO']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['orderId'] = orderId;
    _data['date'] = date;
    _data['status'] = status;
    _data['customer'] = customer.toJson();
    _data['productsResponseDTO'] = productsResponseDTO;
    return _data;
  }
}

class Customer {
  Customer({
    required this.name,
    required this.mobileNo,
    required this.address,
    required this.id,
    required this.hibernateLazyInitializer,
  });
  late final String name;
  late final String mobileNo;
  late final String address;
  late final int id;
  late final HibernateLazyInitializer hibernateLazyInitializer;

  Customer.fromJson(Map<String, dynamic> json){
    name = json['name'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    id = json['id'];
    hibernateLazyInitializer = HibernateLazyInitializer.fromJson(json['hibernateLazyInitializer']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['mobileNo'] = mobileNo;
    _data['address'] = address;
    _data['id'] = id;
    _data['hibernateLazyInitializer'] = hibernateLazyInitializer.toJson();
    return _data;
  }
}

class HibernateLazyInitializer {
  HibernateLazyInitializer();

  HibernateLazyInitializer.fromJson(Map json);

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    return _data;
  }
}

class ProductsResponseDTO {
  ProductsResponseDTO({
    required this.productId,
    this.productName,
    required this.price,
    required this.quantity,
    this.comment,
    required this.productImage,
    this.createdDate,
    this.updatedDate,
    required this.categoryId,
    required this.subCategoryId,
  });
  late final int productId;
  late final String? productName;
  late final int price;
  late final int quantity;
  late final String? comment;
  late final String? productImage;
  late final String? createdDate;
  late final String? updatedDate;
  late final int categoryId;
  late final int subCategoryId;

  ProductsResponseDTO.fromJson(Map<String, dynamic> json){
    productId = json['productId'];
    productName = json['productName'];
    price = json['price'];
    quantity = json['quantity'];
    comment = json['comment'];
    productImage = json['productImage'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
    categoryId = json['categoryId'];
    subCategoryId = json['subCategoryId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productId'] = productId;
    _data['productName'] = productName;
    _data['price'] = price;
    _data['quantity'] = quantity;
    _data['comment'] = comment;
    _data['productImage'] = productImage;
    _data['createdDate'] = createdDate;
    _data['updatedDate'] = updatedDate;
    _data['categoryId'] = categoryId;
    _data['subCategoryId'] = subCategoryId;
    return _data;
  }
}