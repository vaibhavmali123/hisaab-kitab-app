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
  var _currentIndex=1;

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
      body: listNavigationItems[_currentIndex],
    );
     }

  getBottomNavigation() {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      child: BottomNavigationBar(
        backgroundColor: ColorResources.primaryColor,
        unselectedLabelStyle: TextStyle(color: Colors.orange),
        unselectedItemColor: Colors.black87.withOpacity(0.7),
        currentIndex: _currentIndex,
        onTap: onTapBottomNav,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label:'Home'),
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