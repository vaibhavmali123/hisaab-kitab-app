import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hisab_kitab/utils/colors.dart';

import '../../utils/StringResources.dart';

class AddCategoryScreen extends StatefulWidget{
  
  State createState()=>AddCategoryScreenState();
}

class AddCategoryScreenState extends State<AddCategoryScreen>{

  TextEditingController categoryCtrl=TextEditingController();

  @override
  Widget build(BuildContext context)
  {
  return Scaffold(
    appBar: AppBar(backgroundColor: ColorResources.primaryColor,title: Text('Add Category',style: Theme.of(context).textTheme.headline6,),
        automaticallyImplyLeading: false,leading: Icon(Icons.arrow_back,color: Colors.black87,),),

    body:Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getCategoryField(),
        SizedBox(height: 20,),
        submitButton()
      ],
    )
  );
  }

  getCategoryField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
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
            height: 56,
            width: double.infinity,
            child: TextFormField(
              controller:categoryCtrl,

              style: TextStyle(color: Colors.black, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                // hintText: StringResources.enterProductNameField,
                labelText:StringResources.entercategoryNameField,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: EdgeInsets.only(bottom: 6),
                floatingLabelStyle:TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),
                hintStyle: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.w800),
              ),
            ),
          ),
        ));
  }
  submitButton() {
    return GestureDetector(
      onTap: () {


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
          child: Text('Submit',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }
}