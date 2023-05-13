import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class ReusableWidgets
{

 static InputBorder inputBorder=OutlineInputBorder(
   borderSide: BorderSide(color: Colors.black45,width: 1),
 ) as InputBorder;

 static InputBorder focusedInputBorder=OutlineInputBorder(
   borderSide: BorderSide(color: Colors.black87,width: 1),
 ) as InputBorder;

 static InputBorder errorInputBorder=OutlineInputBorder(
   borderSide: BorderSide(color: Colors.red,width: 1),
 ) as InputBorder;

 static InputBorder focussedErrorInputBorder=OutlineInputBorder(
   borderSide: BorderSide(color: Colors.red,width: 1),
 ) as InputBorder;

 static Widget loader=Center(child: CircularProgressIndicator());

 static BoxDecoration dropDownBorder=BoxDecoration(
   borderRadius: BorderRadius.circular(20),
  border: Border.all(width: 1,color: Colors.black87)
 );

 static showToast({required String msg,required bool type}){
   Fluttertoast.showToast(msg: msg,textColor:Colors.white ,
     toastLength: Toast.LENGTH_LONG,
     gravity: ToastGravity.CENTER,
     backgroundColor:type==true?Colors.green:Colors.red,fontSize: 18, );
 }
static getSubcategoryDropdownShimmer(){
  return Shimmer.fromColors(
      baseColor: Colors.grey.shade500, highlightColor: Colors.grey.shade100,
      child:Container(height: 45,width: 130,));
}
 static getShimerHorizantalList(){
   return Shimmer.fromColors(
       baseColor: Colors.grey.shade500, highlightColor: Colors.grey.shade100,
       child:ListView.builder(
           itemCount: 5,
           scrollDirection: Axis.horizontal,
           itemBuilder:(context,index){
         return Container(height: 45,width: 130,);
       }));
 }
 static getShimmerGrid(BuildContext context){
   return Shimmer.fromColors(
     baseColor: Colors.grey.shade500, highlightColor: Colors.grey.shade100,
     enabled: true,
       child:GridView.builder(
           itemCount: 14,
           primary:false,
           shrinkWrap:true,
           gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
               childAspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.width, crossAxisCount: 3),
           itemBuilder: (context,index){
             return Container(
                 height: MediaQuery.of(context).size.height/5,
                 width: double.infinity,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(16),),
                 ),
                 child: GestureDetector(

                   child: Card(
                       child:Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children:[
                             SizedBox(height: 10),
                             Image.asset("",fit: BoxFit.fill,height: 120,width: 100,),
                             Container(
                               width: double.infinity,
                               height: 30,
                               decoration: BoxDecoration(
                                   color: ColorResources.primaryColor
                               ),
                               child: Center(
                                 child: Text("",style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w600),),
                               ),
                             )
                           ]
                       )
                   ),
                 )
             );
           }),
       );
 }

}