import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hisab_kitab/feature/cart/CartModel.dart';
import 'package:hisab_kitab/feature/order/model/PlaaceOrderRequest.dart';
import 'package:hisab_kitab/networking/ApiProvider.dart';
import 'package:hisab_kitab/networking/EndPoint.dart';
import 'package:hisab_kitab/utils/LoadingNotifier.dart';
import 'package:hisab_kitab/utils/ReusableWidgets.dart';
import 'package:hisab_kitab/utils/StringResources.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hisab_kitab/feature/cart/CartState.dart';

class CartPage extends StatefulWidget{

  final ProductsSelectionState state;
  CartPage(this.state);

  State<CartPage> createState()=>CartPageState();
}
class CartPageState extends State<CartPage>{
  final List<OrderList> orderList=[];
  List<CartModel>cartList=[];
  @override
  void initState() {
    // TODO: implement initState
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(child: Scaffold(
      bottomNavigationBar: getBottomBar(context),
      body:SafeArea(
          child:Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Material(
                  child: Column(
                    children: [
                      Expanded(flex:1,child:Container(
                        width: MediaQuery.of(context).size.width,
                        height: 20,
                        color:ColorResources.primaryColor,
                        child:
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Padding(padding: EdgeInsets.only(left: 8),child:
                            SizedBox(
                                height: 47,
                                child: IconButton(onPressed:(){
                                  Navigator.pop(context,cartList.length);
                                  }, icon:Icon(Icons.arrow_back,size: 30,),color: Colors.black87,)
                            ),),
                            Text('Place Order',style: Theme.of(context).textTheme.headline6,),
                          ],
                        ),
                      )),
                      Expanded(
                          flex: 10,
                          child:
                          cartList.length>0?ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount:cartList.length,
                              primary: false,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder:(context,index){
                                return GestureDetector(
                                    onTap: (){

                                    },
                                    child:Container(
                                        margin: EdgeInsets.only(left: 6,right: 6,top: 5,bottom: 5),
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        //height: 75,
                                        child:Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(cartList[index].productName,style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.9),)
                                                ),
                                                RichText(text:
                                                TextSpan(text: "Quantity:",style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.7)),
                                                    children: <TextSpan>[
                                                      TextSpan(text:
                                                      cartList[index].quantity.toString()
                                                          ,style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                                    ]
                                                ),)],
                                            ),

                                            SizedBox(height: 5,),
                                            Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  RichText(text:
                                                  TextSpan(text: "In stock: ",style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.7)),
                                                      children: <TextSpan>[
                                                        TextSpan(text:cartList[index].inStockQTY.toString(),style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                                      ]
                                                  ),),
                                                  RichText(text:
                                                  TextSpan(text: "Price:",style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.7)),
                                                      children: <TextSpan>[
                                                        TextSpan(text:cartList[index].price.toString(),style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                                      ]
                                                  ),)
                                                ]
                                            )
                                          ],
                                        )
                                    )
                                );
                              }):Center(
                            child:Text("No DATA"),
                          )
                      )
                    ],
                  ),
                ),
              ),
              Consumer<LoaderNotifier>(builder:(context,data,child){
                return data.loading==true?ReusableWidgets.loader:Container();
              })
            ],
          )
      ),
    ), onWillPop:()async{

      Navigator.pop(context,cartList.length);
      print("SIZE: ${cartList.length}");
      if(cartList.isNotEmpty){
        print("SIZE: from if");
        return true;
      }else{
        print("SIZE: from else");
        return false;
      }
    });
  }

  getBottomBar(BuildContext context) {

    return Container
      (
      color:ColorResources.primaryColor,
      //width: MediaQuery.of(context).size.width,
      height: 55,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children:[
          SizedBox(
            //width:100 ,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width/2.5,
              color: Colors.green,
              onPressed: ()async{
                orderList.clear();
                  for(int i=0;i<widget.state.cartList.length;i++){
                                      orderList.add(OrderList(productId:widget.state.cartList[i].productId,
                                          customerId: 1,
                                          date:DateTime.now().toString() ,
                                          price: widget.state.cartList[i].price,
                                          quantity: widget.state.cartList[i].quantity,
                                          status: "paid"));
                                    }
                                    var request={
                                      "orderList":orderList
                                    };
                                    print("REQ ${json.encode(request)}");
                                    var provider=Provider.of<LoaderNotifier>(context,listen: false);
                                    await provider.postData(baseUrl: ApiProvider.baseUrl,
                                        endApi:EndPoint.saveOrder+"36",request:json.encode(request));

                                    print("REQ ${json.encode(request)}");
                                    if(provider.isBack){
                                      print("REQ ${provider.isBack}");
                                      ReusableWidgets.showToast(msg:StringResources.orderSuccess, type: true);
                                      provider.loading=false;
                                      cartList.clear();
                                      setState(() {
                                      });
                                    }

                                    else{
                                      setState(() {
                                        //  categoryField=false;
                                      });
                                    }

              }, child: Text('Place order',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            ),
          ),SizedBox(width: 20,)
        ]
      ),
    );
  }

  void initialize() {
    for(int i=0;i<widget.state.cartList.length;i++)
      {
        cartList.add(widget.state.cartList[i]);
      }

  }
}