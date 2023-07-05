import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hisab_kitab/feature/order/bloc/OrderEvent.dart';
import 'package:hisab_kitab/feature/order/bloc/OrderState.dart';
import 'package:hisab_kitab/feature/order/bloc/OrdersBloc.dart';
import 'package:hisab_kitab/utils/ReusableWidgets.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:hisab_kitab/utils/ExtendedText.dart';
import 'package:intl/intl.dart';
class OrdersNav extends StatefulWidget{

  State<OrdersNav>createState()=>OrdersNavState();
}

class OrdersNavState extends State<OrdersNav>
{
  DateFormat dateformat=DateFormat('yyyy-MM-dd HH:mm');
  final ordersBloc=OrdersBloc();
  @override
  void initState() {
    ordersBloc.add(GetAllOrdersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("All Orders",style: TextStyle(fontSize: 16,color:ColorResources.title1Color),),
//          leading: IconButton(onPressed:(){Navigator.pop(context);}, icon:Icon(Icons.arrow_back),color: Colors.black87,),
          backgroundColor:ColorResources.primaryColor),
      body: BlocProvider(create: (_)=>ordersBloc,
      child: BlocListener<OrdersBloc,OrderState>(listener:(context,state){
        if(state is ErrorOrderState){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(state.message!),
            ),
          );
        }
      },
      child: BlocBuilder<OrdersBloc,OrderState>(
        builder: (context,state){
          if(state is InitialOrderState){
            return ReusableWidgets.getShimerListVertical(context);
          }
          else if(state is LoadingOrdersState){

            return ReusableWidgets.getShimerListVertical(context);
          }
          else if(state is LoadedOrdersState){
            print("STATUS: ${state.ordersModel.statusCode}");
            return state.ordersModel.list.length>0?ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: state.ordersModel.list.length,
                primary: false,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder:(context,index){
                  return GestureDetector(
                      onTap: (){
                        print("gg: ${state.ordersModel.list[index].productsResponseDTO?.productName}");
                      },
                      child:Container(
                          margin: EdgeInsets.only(left: 6,right: 6,top: 5,bottom: 5),
                          padding: EdgeInsets.all(14),
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
                            Container(
                              width:100,
                              child: Text(
                                state.ordersModel.list[index].customer.name.toString(),
                              ).withTestStyle(
                                size: 14.0,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                                opacity: 0.8,
                                fontFamily: "Poppins",
                                textOverflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(letterSpacing: 1.2),
                              ),
                            ),
                                 // Text(state.ordersModel.list[index].customer.name.toString(),style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.9),)

                                  RichText(text:
                                  TextSpan(text: "Quantity: ",style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.7)),
                                      children: <TextSpan>[
                                        TextSpan(text: state.ordersModel.list[index].productsResponseDTO?.quantity.toString(),style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                      ]
                                  ),overflow: TextOverflow.ellipsis,)
                                ],
                              ),
                              SizedBox(height: 15,),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(width: 120,
                                    child: RichText(text:
                                    TextSpan(text: state.ordersModel.list[index].productsResponseDTO?.productName,style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.7)),
                                        children: <TextSpan>[
                                          TextSpan(text: "",style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                        ]
                                    ),overflow: TextOverflow.ellipsis),),
                                    Container(
                                      width: 180,
                                    child: RichText(text:
                                    TextSpan(text: "",style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.7)),
                                        children: <TextSpan>[
                                          TextSpan(text: dateformat.format(DateTime.parse(state.ordersModel.list[index].date.toString())),style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                        ]
                                    ),overflow: TextOverflow.ellipsis,),),
                                  ]
                              )
                            ],
                          )
                      )
                  );
                }):Container(
              height: MediaQuery.of(context).size.height/2,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("No products found for selected category"),
                  )
                ],
              ),
            );

          }
          else{
            return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child:Text("no data"),
              ),
            );
          }
        },
      ),
      ),
      )
    );
  }
}