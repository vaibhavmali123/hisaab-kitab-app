import '../../networking/ApiHandler.dart';
import 'model/SubcategoriesModel.dart';

import '../../networking/ApiProvider.dart';
import '../../networking/EndPoint.dart';
class SubCategoryRepository
{

  Future<SuubcategoriesModel> getSubcategories(int categoryId)async{

    Map<String,dynamic>?mapRes={};
   await ApiHandler.getApi(baseUrl: ApiProvider.baseUrl, endApi: EndPoint.getSubCategoriesById+categoryId.toString()).then((value) {
      mapRes=value;
      print("URL: "+ApiProvider.baseUrl+EndPoint.getSubCategoriesById+categoryId.toString());
      print("RESSrfrr 1 ${value.toString()}");

    });
    print("RESS n ${mapRes.toString()}");

    return SuubcategoriesModel.fromJson(mapRes!);
  }
}