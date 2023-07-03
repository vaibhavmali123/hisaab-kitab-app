class PlaceOrderRequest {
  PlaceOrderRequest({
    required this.orderList,
  });
  late final List<OrderList> orderList;


  PlaceOrderRequest.fromJson(Map<String, dynamic> json){
    orderList = List.from(json['orderList']).map((e)=>OrderList.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['orderList'] = orderList.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class OrderList {
  OrderList({
    required this.productId,
    required this.customerId,
    required this.quantity,
    required this.price,
    required this.date,
    required this.status,
  });
  late final int productId;
  late final int customerId;
  late final int quantity;
  late final int price;
  late final String date;
  late final String status;

  OrderList.fromJson(Map<String, dynamic> json){
    productId = json['productId'];
    customerId = json['customerId'];
    quantity = json['quantity'];
    price = json['price'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['productId'] = productId;
    _data['customerId'] = customerId;
    _data['quantity'] = quantity;
    _data['price'] = price;
    _data['date'] = date;
    _data['status'] = status;
    return _data;
  }
}