import 'package:dio/dio.dart';
import 'package:hisab_kitab/networking/ApiHandler.dart';
import 'package:hisab_kitab/feature/category/model/CategoriesModel.dart';
import 'package:hisab_kitab/networking/EndPoint.dart';
import 'package:hisab_kitab/networking/ApiProvider.dart';
import 'package:http/http.dart' as http;
import 'package:hisab_kitab/feature/products/model/ProductsModel.dart';
class ProductsRepository{
  Future<ProductsModel> getSubProducts(int categoryId,int subCategoryId)async{
//?categoryId=75&subCategoryId=26
    Map<String,dynamic>?mapRes={};
    await ApiHandler.getApi(baseUrl: ApiProvider.baseUrl,
        endApi: EndPoint.getProductsById+"?categoryId="+categoryId.toString()+"&subCategoryId="+subCategoryId.toString()).then((value) {
      mapRes=value;
      print("URL from repo: "+ApiProvider.baseUrl+EndPoint.getProductsById+categoryId.toString());
      print("RESS from repo ${value.toString()}");
    });
    print("RESS2 from repo ${mapRes.toString()}");
    return ProductsModel.fromJson(mapRes!);
  }


}