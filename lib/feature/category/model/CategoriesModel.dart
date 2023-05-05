class CategoriesModel {

CategoriesModel.forInst();

	CategoriesModel({
		required this.statusCode,
		required this.message,
		required this.list,
	});
	late final String statusCode;
	late final String message;
	late final List<ListItems> list;

	CategoriesModel.fromJson(Map<String, dynamic> json){
		statusCode = json['statusCode'];
		message = json['message'];
		list = List.from(json['list']).map((e)=>ListItems.fromJson(e)).toList();
	}

	Map<String, dynamic> toJson() {
		final _data = <String, dynamic>{};
		_data['statusCode'] = statusCode;
		_data['message'] = message;
		_data['list'] = list.map((e)=>e.toJson()).toList();
		return _data;
	}

}

class ListItems {
	ListItems({
		required this.categoryId,
		this.categoryName,
		this.createdDate,
		required this.sequence,
		required this.active,
	});
	late final int categoryId;
	late final String? categoryName;
	late final Null createdDate;
	late final int sequence;
	late final bool active;

	ListItems.fromJson(Map<String, dynamic> json){
		categoryId = json['categoryId'];
		categoryName = null;
		createdDate = null;
		sequence = json['sequence'];
		active = json['active'];
	}

	Map<String, dynamic> toJson() {
		final _data = <String, dynamic>{};
		_data['categoryId'] = categoryId;
		_data['categoryName'] = categoryName;
		_data['createdDate'] = createdDate;
		_data['sequence'] = sequence;
		_data['active'] = active;
		return _data;
	}
}