import 'package:flutter/material.dart';
import 'package:hisab_kitab/feature/dashboard/HomePageNav.dart';
import 'package:hisab_kitab/feature/dashboard/OrdersNav.dart';
import 'package:hisab_kitab/feature/dashboard/ProductsNav.dart';
import 'package:hisab_kitab/feature/dashboard/ProfileNav.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

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
}