class CustomerModel {
  CustomerModel({
    required this.statusCode,
    required this.message,
    required this.list,
  });
  late final String statusCode;
  late final String message;
  late final List<Customer> list;

  CustomerModel.fromJson(Map<String, dynamic> json){
    statusCode = json['statusCode'];
    message = json['message'];
    list = List.from(json['list']).map((e)=>Customer.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['list'] = list.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Customer {
  Customer({
    required this.name,
    required this.mobileNo,
    required this.address,
    required this.id,
  });
  late final String name;
  late final String mobileNo;
  late final String address;
  late final int id;

  Customer.fromJson(Map<String, dynamic> json){
    name = json['name'];
    mobileNo = json['mobileNo'];
    address = json['address'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['mobileNo'] = mobileNo;
    _data['address'] = address;
    _data['id'] = id;
    return _data;
  }
}