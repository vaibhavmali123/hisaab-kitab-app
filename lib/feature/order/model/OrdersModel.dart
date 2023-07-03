class OrdersModel {
  OrdersModel({
    required this.statusCode,
    required this.message,
    required this.list,
  });
  late final String statusCode;
  late final String message;
  late final List<OrdersList> list;

  OrdersModel.fromJson(Map<String, dynamic> json){
    statusCode = json['statusCode'];
    message = json['message'];
    list = List.from(json['list']).map((e)=>OrdersList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['list'] = list.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class OrdersList {
  OrdersList({
    this.customerName,
    required this.customer,
    required this.productId,
    required this.customerId,
    required this.quantity,
    required this.price,
    required this.date,
    required this.status,
  });
  late final Null customerName;
  late final Customer customer;
  late final int productId;
  late final int customerId;
  late final int quantity;
  late final int price;
  late final String date;
  late final String status;

  OrdersList.fromJson(Map<String, dynamic> json){
    customerName = null;
    customer = Customer.fromJson(json['customer']);
    productId = json['productId'];
    customerId = json['customerId'];
    quantity = json['quantity'];
    price = json['price'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['customerName'] = customerName;
    _data['customer'] = customer.toJson();
    _data['productId'] = productId;
    _data['customerId'] = customerId;
    _data['quantity'] = quantity;
    _data['price'] = price;
    _data['date'] = date;
    _data['status'] = status;
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