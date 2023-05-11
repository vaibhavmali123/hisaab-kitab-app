class SuubcategoriesModel {
  SuubcategoriesModel({
    required this.statusCode,
    required this.message,
    required this.list,
  });
  late final String statusCode;
  late final String message;
  late final List<ListElemet> list;

  SuubcategoriesModel.fromJson(Map<String, dynamic> json){
    statusCode = json['statusCode'];
    message = json['message'];
    list = List.from(json['list']).map((e)=>ListElemet.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['statusCode'] = statusCode;
    _data['message'] = message;
    _data['list'] = list.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ListElemet {
  ListElemet({
    required this.subCategoryId,
    required this.subCategoryName,
    required this.createdDate,
    required this.sequence,
    required this.category,
    required this.active,
    required this.categoryId,
  });
  late final int subCategoryId;
  late final String subCategoryName;
  late final String createdDate;
  late final int sequence;
  late final Category category;
  late final bool active;
  late final int categoryId;

  ListElemet.fromJson(Map<String, dynamic> json){
    subCategoryId = json['subCategoryId'];
    subCategoryName = json['subCategoryName'];
    createdDate = json['createdDate'];
    sequence = json['sequence'];
    category = Category.fromJson(json['category']);
    active = json['active'];
    categoryId = json['categoryId'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['subCategoryId'] = subCategoryId;
    _data['subCategoryName'] = subCategoryName;
    _data['createdDate'] = createdDate;
    _data['sequence'] = sequence;
    _data['category'] = category.toJson();
    _data['active'] = active;
    _data['categoryId'] = categoryId;
    return _data;
  }
}

class Category {
  Category({
    required this.categoryId,
    this.categoryName,
    required this.createdDate,
    required this.sequence,
    required this.active,
    required this.hibernateLazyInitializer,
  });
  late final int categoryId;
  late final String? categoryName;
  late final String createdDate;
  late final int sequence;
  late final bool active;
  late final HibernateLazyInitializer hibernateLazyInitializer;

  Category.fromJson(Map<String, dynamic> json){
    categoryId = json['categoryId'];
    categoryName = null;
    createdDate = json['createdDate'];
    sequence = json['sequence'];
    active = json['active'];
    hibernateLazyInitializer = HibernateLazyInitializer.fromJson(json['hibernateLazyInitializer']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['categoryId'] = categoryId;
    _data['categoryName'] = categoryName;
    _data['createdDate'] = createdDate;
    _data['sequence'] = sequence;
    _data['active'] = active;
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