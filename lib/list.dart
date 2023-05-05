
class List {

  int categoryId;
  Object categoryName;
  Object createdDate;
  int sequence;
  bool active;

	List.fromJsonMap(Map<String, dynamic> map): 
		categoryId = map["categoryId"],
		categoryName = map["categoryName"],
		createdDate = map["createdDate"],
		sequence = map["sequence"],
		active = map["active"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['categoryId'] = categoryId;
		data['categoryName'] = categoryName;
		data['createdDate'] = createdDate;
		data['sequence'] = sequence;
		data['active'] = active;
		return data;
	}
}
