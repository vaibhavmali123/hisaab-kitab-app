import 'package:hisab_kitab/feature/customer/model/CustomerModel.dart';
import 'package:hisab_kitab/networking/ApiHandler.dart';
import 'package:hisab_kitab/networking/ApiProvider.dart';
import 'package:hisab_kitab/networking/EndPoint.dart';
class CustomerRepository{

  Future<CustomerModel> getCustomers()async{
//?categoryId=75&subCategoryId=26
    Map<String,dynamic>?mapRes={};
    await ApiHandler.getApi(baseUrl: ApiProvider.baseUrl,
        endApi: EndPoint.getAllCustomers).then((value) {
      mapRes=value;
      print("URL from repo: "+ApiProvider.baseUrl+EndPoint.getAllCustomers);
      print("RESS from repo ${value.toString()}");
    });
    print("RESS2 from repo ${mapRes.toString()}");
    return CustomerModel.fromJson(mapRes!);
  }

}