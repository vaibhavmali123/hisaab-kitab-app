import 'package:flutter/material.dart';
import 'package:hisab_kitab/utils/colors.dart';
import '../category/AddCategoryScreen.dart';
import '../subcategory/AddSubcategoryScreen.dart';
import 'package:hisab_kitab/feature/dashboard/ProductsNav.dart';

import 'CategoryMaster.dart';

class AdminDashboard extends StatefulWidget
{

  AdminDashboardState createState()=>AdminDashboardState();
}

class AdminDashboardState extends State<AdminDashboard>{
List<String>menuList=["Category Master","Sub category Master","Products Master","Reports Master"];
int currentIndex=0;
  @override
  Widget build(BuildContext context)
  {
  return Scaffold(
    appBar: AppBar(title: Text("Admin Dashboard",style: TextStyle(fontSize: 14,color: Colors.white),),
      backgroundColor:ColorResources.primaryColor),
    body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child:Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(top:12),
                  height: 40,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: menuList.length,
                    itemBuilder: (context,index){
                      return  GestureDetector(
                        onTap: (){
                          setState(() {
                            currentIndex=index;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 4,right: 4),
                          padding: EdgeInsets.all(5),
                          child: Center(
                            child: Text(menuList[index],style: TextStyle(fontSize: 12,fontWeight: currentIndex!=index?FontWeight.w600:FontWeight.w900,color:currentIndex!=index?Colors.black87:ColorResources.primaryColor),),
                          ),
                          // width: MediaQuery.of(context).size.width/5,
                          height: 35,
                          decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(width:currentIndex!=index? 1:2,color:currentIndex!=index?Colors.black87:ColorResources.primaryColor)
                          ) ,
                        ),
                      );

                    },),
                )),
            Expanded(
                flex: 12,
                child:getChild(currentIndex))
          ],
        ),
      ),
    ),
  );
  }
  getChild(int index){

    switch(index){

      case 0:
        return AddCategoryScreen();
        break;
      case 1:
        return AddSubcategoryScreen();
        break;
      case 2:
        return ProductsNav();
        break;
    }
  }
}