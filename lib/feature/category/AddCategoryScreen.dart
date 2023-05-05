import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:hisab_kitab/networking/ApiProvider.dart';
import 'package:hisab_kitab/networking/ApiHandler.dart';
import '../../utils/ReusableWidgets.dart';
import '../../utils/StringResources.dart';
import 'package:hisab_kitab/networking/EndPoint.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:hisab_kitab/utils/LoadingNotifier.dart';
import 'dart:convert';
class AddCategoryScreen extends StatefulWidget{
  
  State createState()=>AddCategoryScreenState();
}

class AddCategoryScreenState extends State<AddCategoryScreen>{

  TextEditingController categoryCtrl=TextEditingController();
  List<String> categoryList=["1","2","3","4","5","6","7","8","9","10"];
  var selectedSequence;
  bool categoryField=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
  return Scaffold(
    resizeToAvoidBottomInset: false,


    body:SingleChildScrollView(
      child:Stack(
        children: [
          Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),

                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text("Add Category",style: TextStyle(fontSize: 12,color:Colors.black87,fontWeight: FontWeight.w900),),
                ),
                SizedBox(height: 4,),

                getCategoryField(),
                //SizedBox(height: 4,),
                //getsequenceDropdown(),
                submitButton(),

                Container(
                margin: EdgeInsets.only(top: 10),
                  width: double.infinity,
                  height: 1,color: Colors.black87,)
              ],
            ),
          ),
          Consumer<LoaderNotifier>(builder:(context,data,child){

            return data.loading==true?ReusableWidgets.loader:Container();
          })
          //showLoader==true?Center(child: CircularProgressIndicator(),):Container()
        ],
      ),
    )
  );
  }

  getCategoryField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
        child: TextFormField(
          controller:categoryCtrl,
          autovalidateMode: AutovalidateMode.disabled,autofocus: true,
          style: TextStyle(color: Colors.black, fontSize: 14),
          decoration: InputDecoration(
           border: ReusableWidgets.inputBorder,
            enabledBorder:ReusableWidgets.inputBorder,
            focusedBorder:ReusableWidgets.focusedInputBorder,
            errorBorder:categoryField==false?ReusableWidgets.focussedErrorInputBorder:ReusableWidgets.inputBorder,
            focusedErrorBorder:categoryField==false?ReusableWidgets.focussedErrorInputBorder:ReusableWidgets.inputBorder,
            errorText: categoryField==false?"Please enter category":"",
            // hintText: StringResources.enterProductNameField,
            labelText:StringResources.entercategoryNameField,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.only(bottom: 6,left: 10),
            floatingLabelStyle:TextStyle(color: categoryField==true?Colors.black:Colors.red, fontSize: 15,fontWeight: FontWeight.w700),
            hintStyle: TextStyle(color:categoryField==true?Colors.black:Colors.red, fontSize: 16,fontWeight: FontWeight.w800),

          ),
        ));
  }
  submitButton() {
    return
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 45,
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width/1.1,
              color: ColorResources.primaryColor,
              onPressed: ()async{

                if(categoryCtrl.text.length>0){

                  var request={
                    "categoryName":categoryCtrl.text,
                    "sequence":'2'};

                  var provider=Provider.of<LoaderNotifier>(context,listen: false);
                  await provider.postData(baseUrl: ApiProvider.baseUrl, endApi:EndPoint.saveCategory,request:json.encode(request));
                  if(provider.isBack){
                    // Navigator.pop(context);
                  }
                }
                else{
                  setState(() {
                    categoryField=false;
                  });
                }

              }, child: Text('Submit',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            ),
          )
        ],
      );
/*
      GestureDetector(
      onTap: () async{
        if(categoryCtrl.text.length>0){

          var request={
            "categoryName":categoryCtrl.text,
            "sequence":'2'};

          var provider=Provider.of<LoaderNotifier>(context,listen: false);
          await provider.postData(baseUrl: ApiProvider.baseUrl, endApi:EndPoint.saveCategory,request:json.encode(request));
          if(provider.isBack){
           // Navigator.pop(context);
          }
        }
        else{
          setState(() {
            categoryField=false;
          });
        }

        */
/* ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Clicked')));*//*

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
*/
  }

  getsequenceDropdown() {
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
                    value: selectedSequence,
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
                        selectedSequence=value;
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