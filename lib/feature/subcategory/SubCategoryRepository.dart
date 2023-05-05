import '../../networking/ApiHandler.dart';
import 'model/SubcategoriesModel.dart';

import '../../networking/ApiProvider.dart';
import '../../networking/EndPoint.dart';
class SubCategoryRepository
{

  Future<SuubcategoriesModel> getSubcategories()async{

    Map<String,dynamic>?mapRes={};
    Future<Map<String, dynamic>?> map=ApiHandler.getApi(baseUrl: ApiProvider.baseUrl, endApi: EndPoint.addSubCategory).then((value) {
      mapRes=value;
    });
    return SuubcategoriesModel.fromJson(mapRes!);
  }
}