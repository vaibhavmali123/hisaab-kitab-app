import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter/services.dart';
import 'package:hisab_kitab/feature/dashboard/Dashboard.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget{

  State<LoginScreen> createState()=>LoginScreenState();
}

class LoginScreenState extends State<LoginScreen>
{
  TextEditingController? userNameCtrl,passwordCtrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SvgPicture.asset(
                        "assets/pos_system.svg",
                        height:120,
                        width:120,
                        //color:ColorResources.primaryColor,
                        //colorFilter: ColorFilter.mode(Colors.red, BlendMode.srcIn),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      emailField(),
                      passwordField(),
                      SizedBox(
                        height: 5,
                      ),
                      forgotPassword(),
                      SizedBox(height: 31),
                      loginButton(),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
   }

  // neumorphic flutter login ui page template
  Widget emailField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 10),
        child: Neumorphic(
          style: NeumorphicStyle(
              color: Colors.white,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(100)
                  .copyWith(topRight: Radius.circular(0))),
              depth: -4,
              lightSource: LightSource.bottomLeft,
              intensity: 1,
              // oppositeShadowLightSource: true,
              shadowLightColorEmboss: Colors.white24),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 53,
            width: double.infinity,
            child: TextField(
              controller:userNameCtrl,
              style: TextStyle(color: Colors.black, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter email',
                hintStyle: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ));
  }
  // neumorphic flutter login ui page design template
  Widget passwordField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 10),
        child: Neumorphic(
          style: NeumorphicStyle(
              color: Colors.white,
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(100)
                  .copyWith(topRight: Radius.circular(0))),
              depth: -4,
              lightSource: LightSource.bottomLeft,
              intensity: 1,
              // oppositeShadowLightSource: true,
              shadowLightColorEmboss: Colors.white24),
          child: Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 53,
            width: double.infinity,
            child: TextField(
              controller: passwordCtrl,
              style: TextStyle(color: Colors.black, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter password',
                hintStyle: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),
          ),
        ));
  }
  // amazing neumorphic flutter login ui page design template
  Widget loginButton() {
    return GestureDetector(
      onTap: () {
        if(userNameCtrl!.text.toString().trim()=="admin" && passwordCtrl!.text.toString().trim()=="admin") {

          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){

            return Dashboard();
          }));
        }
       /* ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Clicked')));*/
      },
      child: Neumorphic(
        margin: EdgeInsets.symmetric(horizontal: 20),
        style: NeumorphicStyle(
            color: Colors.green.shade100,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(100)
                .copyWith(topRight: Radius.circular(0))),
            depth: -4,
            lightSource: LightSource.bottomLeft,
            intensity: 1,
            // oppositeShadowLightSource: true,
            shadowLightColorEmboss: Colors.white54),
        child: Container(
          height: 53,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.center,
          child: Text('Login',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
  // neumorphic flutter login ui page design template
  Widget forgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, right: 30),
        child: InkWell(
          onTap: () {
            // can specify actions here
          },
          child: Text(
            'Forgot password?',
            style: TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }

  void initialize() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.grey, // status bar color
    ));

    userNameCtrl=TextEditingController();
    passwordCtrl=TextEditingController();

  }
}