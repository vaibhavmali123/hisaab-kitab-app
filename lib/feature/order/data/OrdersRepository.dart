import 'package:hisab_kitab/feature/order/model/OrdersModel.dart';
import 'package:hisab_kitab/networking/ApiHandler.dart';
import 'package:hisab_kitab/networking/ApiProvider.dart';
import 'package:hisab_kitab/networking/EndPoint.dart';

class OrdersRepository{

  Future<OrdersModel> getAllOrders()async{
    Map<String,dynamic>?mapRes={};
    await ApiHandler.getApi(baseUrl: ApiProvider.baseUrl,
        endApi: EndPoint.getAllOrders).then((value) {
      mapRes=value;
      print("URL from repo: "+ApiProvider.baseUrl+EndPoint.getAllOrders);
      print("RESS from repo ${value.toString()}");
    });
    print("RESS2 from repo ${mapRes.toString()}");
    return OrdersModel.fromJson(mapRes!);
  }

}