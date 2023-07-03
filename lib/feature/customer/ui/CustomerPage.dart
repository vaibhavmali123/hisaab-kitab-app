import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hisab_kitab/feature/customer/bloc/CustomerBloc.dart';
import 'package:hisab_kitab/feature/customer/bloc/CustomerEvent.dart';
import 'package:hisab_kitab/feature/customer/bloc/CustomerState.dart';
import 'package:hisab_kitab/utils/ReusableWidgets.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:hisab_kitab/feature/customer/model/CustomerModel.dart';
class CustomerPage extends StatefulWidget{

  State<CustomerPage> createState()=>CustomerPageState();
}

class CustomerPageState extends State<CustomerPage>
{
  final customerBloc=CustomerBloc();
  var customer;
  @override
  void initState() {
    // TODO: implement initState
    customerBloc.add(GetCustomerEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(child: Scaffold(
      appBar: AppBar(title: Text("Customers",style: TextStyle(fontSize: 16,color:ColorResources.title1Color),),
          leading: IconButton(onPressed:(){Navigator.pop(context,customer);}, icon:Icon(Icons.arrow_back),color: Colors.black87,),
          backgroundColor:ColorResources.primaryColor),
      body: BlocProvider(create: (_)=>customerBloc,
        child: BlocListener<CustomerBloc,CustomerState>(listener: (context,state){
          if(state is CustomerErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
          child: BlocBuilder<CustomerBloc,CustomerState>(
            builder: (context,state){
              if(state is CustomerInitialState)
              {
                return ReusableWidgets.getShimerListVertical(context);
              }
              else if(state is CustomerLoadingState)
              {
                return ReusableWidgets.getShimerListVertical(context);
              }
              else if(state is CustomerLoadedState){
                return Padding(padding: EdgeInsets.only(bottom:55),child:
                state.customerModel.list.length>0?ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: state.customerModel.list.length,
                    primary: false,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder:(context,index){
                      return GestureDetector(
                          onTap: (){
                              setState(() {
                                customer=state.customerModel.list[index];
                              });
                              Navigator.pop(context,customer);
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
                                      Text(state.customerModel.list[index].name,style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.9),)
                                      ),
                                      RichText(text:
                                      TextSpan(text: "Mobile: ",style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.7)),
                                          children: <TextSpan>[
                                            TextSpan(text: state.customerModel.list[index].mobileNo.toString(),style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                          ]
                                      ),)
                                    ],
                                  ),
                                  SizedBox(height: 15,),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(text:
                                        TextSpan(text: "Address: ",style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.7)),
                                            children: <TextSpan>[
                                              TextSpan(text: state.customerModel.list[index].address.toString(),style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                            ]
                                        ),),
                                      ]
                                  )
                                ],
                              )
                          )
                      );
                    }):Container(
                  child: Container(
                    height: MediaQuery.of(context).size.height/2,
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text("No products found for selected category"),
                        )
                      ],
                    ),
                  ),
                ),);
              }
              else{
                return Container(
                  child: Text("no data"),
                );            }
            },
          ),
        ),
      ),
    ), onWillPop: ()async{
      Navigator.pop(context,customer);
      return customer;
    });
  }
}