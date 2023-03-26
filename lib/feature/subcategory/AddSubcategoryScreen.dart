import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../utils/StringResources.dart';
import '../../utils/colors.dart';

class AddSubcategoryScreen extends StatefulWidget
{

  State createState()=>AddSubcategoryScreenState();
}

class AddSubcategoryScreenState extends State<AddSubcategoryScreen>
{
  TextEditingController subcategoryCtrl=TextEditingController();
  String? selectedCategory,selectedSubCategory;
  List<String> categoryList=["mobile","Cover","charger"];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
        appBar: AppBar(backgroundColor: ColorResources.primaryColor,title: Text('Add SubCategory',style: Theme.of(context).textTheme.headline6,),
          automaticallyImplyLeading: false,leading: Icon(Icons.arrow_back,color: Colors.black87,),),

        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              getCategoryDropDown(),
            getSubCategoryField(),
            SizedBox(height: 20,),
            submitButton()
          ],
        )
    );
  }

  getSubCategoryField() {
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
              controller:subcategoryCtrl,

              style: TextStyle(color: Colors.black, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                // hintText: StringResources.enterProductNameField,
                labelText:StringResources.entersubcategoryNameField,
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
  getSubcategoryDropdown() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 18),
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
            child:Container(
              height: 54,
              width: MediaQuery.of(context).size.width/1.1,
              child: Center(
                child: Theme(
                  data: Theme.of(context).copyWith(
                      canvasColor: Colors.white,
                      // background color for the dropdown items
                      buttonTheme: ButtonTheme.of(context).copyWith(
                        alignedDropdown: true, //If false (the default), then the dropdown's menu will be wider than its button.
                      )),
                  child: DropdownButton<String>(
                    underline: Container(
                      height: 1.0,
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))),
                    ),

                    isExpanded: true,
                    focusColor: Colors.white,
                    value: selectedSubCategory,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    icon:Icon(Icons.arrow_drop_down),
                    items: categoryList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Select subcategory",
                      style: TextStyle(fontSize: 14,  color:Colors.black54, fontWeight: FontWeight.w400),
                    ),
                    onChanged: (String? value){
                      setState(() {
                        selectedSubCategory=value;
                      });
                    },
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

  getCategoryDropDown() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 18),
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
            child:Container(
              height: 54,
              width: MediaQuery.of(context).size.width/1.1,
              child: Center(
                child: Theme(
                  data: Theme.of(context).copyWith(
                      canvasColor: Colors.white,
                      // background color for the dropdown items
                      buttonTheme: ButtonTheme.of(context).copyWith(
                        alignedDropdown: true, //If false (the default), then the dropdown's menu will be wider than its button.
                      )),
                  child: DropdownButton<String>(
                    underline: Container(
                      height: 1.0,
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))),
                    ),

                    isExpanded: true,
                    focusColor: Colors.white,
                    value: selectedCategory,
                    style: TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.black,
                    icon:Icon(Icons.arrow_drop_down),
                    items: categoryList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                        ),
                      );
                    }).toList(),
                    hint: Text(
                      "Select category",
                      style: TextStyle(fontSize: 14,  color:Colors.black54, fontWeight: FontWeight.w400),
                    ),
                    onChanged: (String? value){
                      setState(() {
                        selectedCategory=value;
                      });
                    },
                  ),
                ),
              ),
            )
        ),
      ),
    );
  }

}