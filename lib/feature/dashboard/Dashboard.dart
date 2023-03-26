import 'package:flutter/material.dart';
import 'package:hisab_kitab/feature/dashboard/HomePageNav.dart';
import 'package:hisab_kitab/feature/dashboard/OrdersNav.dart';
import 'package:hisab_kitab/feature/dashboard/ProductsNav.dart';
import 'package:hisab_kitab/feature/dashboard/ProfileNav.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

import '../category/AddCategoryScreen.dart';
import '../subcategory/AddSubcategoryScreen.dart';

class Dashboard extends StatefulWidget{

  State<Dashboard> createState()=>DashboardState();
}

class DashboardState extends State<Dashboard> {
List<Widget>listNavigationItems=[
  HomePageNav(),
  OrdersNav(),
  ProductsNav(),
  ProfileNav()
];
  var _currentIndex=0;

@override
void initState() {
  // TODO: implement initState
  super.initState();
  initialize();
}

@override
  Widget build(BuildContext context) {

    return Scaffold(
      bottomNavigationBar: getBottomNavigation(),
      drawer: getDrawer(),
      body: IndexedStack(
        index: _currentIndex,
        children: listNavigationItems,
      ),
    );
     }

  getBottomNavigation() {
    return Container(
      margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
      child: BottomNavigationBar(
        backgroundColor: ColorResources.primaryColor,
        unselectedItemColor: Colors.black45,
        elevation: 10,
        selectedLabelStyle: GoogleFonts.poppins(fontSize: 12,color: Colors.black54,fontWeight: FontWeight.w500),

        currentIndex: _currentIndex,
        onTap: onTapBottomNav,
        selectedItemColor: Colors.black87,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label:'Home',),

          BottomNavigationBarItem(
              icon: Icon(Icons.card_travel_sharp),
              label: 'Orders'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.food_bank),
              label: 'Products'
          ), BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              label: 'Profile'
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50))
      ),
    );
  }

  void onTapBottomNav(int value) {
    setState(() {
      _currentIndex = value;
    });
  }

  void initialize() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: ColorResources.primaryColor, // navigation bar color
      statusBarColor: ColorResources.primaryColor, // status bar color
    ));
  }
void navigate(String type) {
  switch (type) {
    case "addCat":
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AddCategoryScreen();
      }));
      break;
    case "addSubcat":
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return AddSubcategoryScreen();
      }));
      break;
    case "addProduct":
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ProductsNav();
      }));
      break;
  }
}

  getDrawer() {
  return Drawer(
      child:IntrinsicHeight(
        child: Container(
          width: MediaQuery.of(context).size.width/1.8,
          height:double.maxFinite,
          //margin: EdgeInsets.only(top: 100),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 180,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: ColorResources.primaryColor
                ),
              ),
              ExpansionTile(title:Text('Admin') ,children: [

                ExpansionTile(title:Text('Category master'),
                  children: [
                    ListTile(title: Text("Add category"),leading: Icon(Icons.add_business_rounded,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),
                      onTap: (){
                        navigate("addCat");
                      },
                    ),

                    ListTile(title: Text("Update/ delete category"),leading: Icon(Icons.edit_note,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),),
                  ],
                ),

                ExpansionTile(title:Text('Subcategory master'),
                  children: [
                    ListTile(title: Text("Add Subcategory"),leading: Icon(Icons.add_business_rounded,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),
                      onTap: (){
                        navigate("addSubcat");
                      },
                    ),

                    ListTile(title: Text("Update/ delete Subcategory"),leading: Icon(Icons.edit_note,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),),
                  ],
                ),

                ExpansionTile(title:Text('Products master'),
                  children: [
                    ListTile(title: Text("Add products"),leading: Icon(Icons.add_business_rounded,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),
                      onTap: (){
                        navigate("addProduct");
                      },
                    ),

                    ListTile(title: Text("Update/ delete products"),leading: Icon(Icons.edit_note,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),),
                  ],
                ),


              ],)
            ],
          ),
        ),
      )
  );
  }
}