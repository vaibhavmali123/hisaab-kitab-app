import 'package:flutter/material.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
class HomePageNav extends StatefulWidget{

  State<HomePageNav> createState()=>HomePageNavState();
}

class HomePageNavState extends State<HomePageNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/2.1,
                padding: EdgeInsets.only(left: 8),
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("200",style: GoogleFonts.poppins(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w800)),
                    SizedBox(height: 10,),
                    Text("Products in",style: GoogleFonts.poppins(fontSize: 20,color: Colors.black87,fontWeight: FontWeight.w800))
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10),),
                gradient: LinearGradient(colors: [Colors.lightGreenAccent,ColorResources.primaryColor])
                ),
        ),

              Container(
                height: 100,
                width: MediaQuery.of(context).size.width/2.1,
                child: Text("Products in"),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(colors: [Colors.lightGreenAccent,ColorResources.primaryColor])
                ),
              )
            ],
          )
        ],
      ))
    );
  }
}