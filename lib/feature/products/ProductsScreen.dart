import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../../../utils/StringResources.dart';
import '../../../utils/colors.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:hisab_kitab/networking/ApiProvider.dart';
import 'package:hisab_kitab/networking/ApiHandler.dart';
import '../../../utils/ReusableWidgets.dart';
import '../../../utils/StringResources.dart';
import 'package:hisab_kitab/networking/EndPoint.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:hisab_kitab/utils/LoadingNotifier.dart';
import 'dart:convert';
class ProductsScreen extends StatefulWidget
{

  ProductsScreenState createState()=> ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen>
{

  TextEditingController? priceCTRL;
  TextEditingController? productNameCTRL;
  TextEditingController? quantityCTRL;

  String? selectedCategory,selectedSubCategory;
  List<String> categoryList=["mobile","Cover","charger"];
  List<String> subCategoryList=["mobile","Cover","charger"];
  bool subCategoryField=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialiaze();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(backgroundColor: ColorResources.primaryColor,title: Text('Add product item',style: Theme.of(context).textTheme.headline6,),
          automaticallyImplyLeading: false,leading: Icon(Icons.arrow_back,color: Colors.black87,),),

        body:SingleChildScrollView(
          physics: BouncingScrollPhysics( ),
          child:Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),

                    getCategoryDropDown(),
                    SizedBox(height: 17,),
                    getSubcategoryDropdown(),
                    SizedBox(height: 17,),
                    getProductNameField(),

                    getProductPriceField(),

                    getProductQTYField(),
                    SizedBox(height: 10,),
                    submitButton()
                  ],
                ),
              ),
              Consumer<LoaderNotifier>(builder:(context,data,child){
                return data.loading?ReusableWidgets.loader:Container();
              })
            ],
          ),
        )
    );
  }

  getProductNameField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
        child: TextFormField(
          controller:productNameCTRL,
          autovalidateMode: AutovalidateMode.disabled,
          autofocus: true,
          style: TextStyle(color: Colors.black, fontSize: 14),
          decoration: InputDecoration(
            border: ReusableWidgets.inputBorder,
            enabledBorder:ReusableWidgets.inputBorder,
            focusedBorder:ReusableWidgets.focusedInputBorder,
            errorBorder:subCategoryField==false?ReusableWidgets.focussedErrorInputBorder:ReusableWidgets.inputBorder,
            focusedErrorBorder:subCategoryField==false?ReusableWidgets.focussedErrorInputBorder:ReusableWidgets.inputBorder,
            errorText: subCategoryField==false?"Please enter product name":"",
            // hintText: StringResources.enterProductNameField,
            labelText:StringResources.enterProductNameField,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.only(bottom: 6,left: 10),
            floatingLabelStyle:TextStyle(color: subCategoryField==true?Colors.black:Colors.red, fontSize: 15,fontWeight: FontWeight.w700),
            hintStyle: TextStyle(color:subCategoryField==true?Colors.black:Colors.red, fontSize: 16,fontWeight: FontWeight.w800),
          ),
        ));
  }
  submitButton() {
    return SizedBox(
      height: 47,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width/1.1,
        color: ColorResources.primaryColor,
        onPressed: ()async{
          var provider=Provider.of<LoaderNotifier>(context,listen: false);
          var request={
            "categoryId":10,
            "subCategoryId":10,
            "productName":productNameCTRL!.text,
            "updatedDate":"2333",
            "quantity":quantityCTRL!.text,
            "price":priceCTRL!.text
          };
          print("Nameee ${productNameCTRL!.text}");
          print("Nameee ${priceCTRL!.text}");


          await provider.postData(baseUrl: ApiProvider.baseUrl, endApi:EndPoint.saveProduct,request:json.encode(request));
          if(provider.isBack){
           // Navigator.pop(context);
          }
        }, child: Text('Submit',
          style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold)),
      ),
    );
  }
  getSubcategoryDropdown() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          alignment: Alignment.centerLeft,
          height: 50,
          width: double.infinity,
          child:Container(
            height: 54,
            width: MediaQuery.of(context).size.width/1.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1,color: Colors.black45)
            ),
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
                  items: subCategoryList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                      ),
                    );
                  }).toList(),
                  hint: Text(
                    "Select Subcategory",
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
    );
  }

  getCategoryDropDown() {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
          alignment: Alignment.centerLeft,
          height: 50,
          width: double.infinity,
          child:Container(
            height: 54,
            width: MediaQuery.of(context).size.width/1.1,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(width: 1,color: Colors.black45)
            ),
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
    );
  }

  getProductPriceField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
        child: TextFormField(
          controller:priceCTRL,
          autovalidateMode: AutovalidateMode.disabled,
          autofocus: true,
          style: TextStyle(color: Colors.black, fontSize: 14),
          decoration: InputDecoration(
            border: ReusableWidgets.inputBorder,
            enabledBorder:ReusableWidgets.inputBorder,
            focusedBorder:ReusableWidgets.focusedInputBorder,
            errorBorder:subCategoryField==false?ReusableWidgets.focussedErrorInputBorder:ReusableWidgets.inputBorder,
            focusedErrorBorder:subCategoryField==false?ReusableWidgets.focussedErrorInputBorder:ReusableWidgets.inputBorder,
            errorText: subCategoryField==false?"Please enter product price":"",
            // hintText: StringResources.enterProductNameField,
            labelText:StringResources.enterProductPriceField,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.only(bottom: 6,left: 10),
            floatingLabelStyle:TextStyle(color: subCategoryField==true?Colors.black:Colors.red, fontSize: 15,fontWeight: FontWeight.w700),
            hintStyle: TextStyle(color:subCategoryField==true?Colors.black:Colors.red, fontSize: 16,fontWeight: FontWeight.w800),
          ),
        ));

  }

  getProductQTYField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
        child: TextFormField(
          controller:quantityCTRL,
          autovalidateMode: AutovalidateMode.disabled,
          autofocus: true,
          style: TextStyle(color: Colors.black, fontSize: 14),
          decoration: InputDecoration(
            border: ReusableWidgets.inputBorder,
            enabledBorder:ReusableWidgets.inputBorder,
            focusedBorder:ReusableWidgets.focusedInputBorder,
            errorBorder:subCategoryField==false?ReusableWidgets.focussedErrorInputBorder:ReusableWidgets.inputBorder,
            focusedErrorBorder:subCategoryField==false?ReusableWidgets.focussedErrorInputBorder:ReusableWidgets.inputBorder,
            errorText: subCategoryField==false?"Please enter product quantity":"",
            // hintText: StringResources.enterProductNameField,
            labelText:StringResources.enterProductQTYField,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.only(bottom: 6,left: 10),
            floatingLabelStyle:TextStyle(color: subCategoryField==true?Colors.black:Colors.red, fontSize: 15,fontWeight: FontWeight.w700),
            hintStyle: TextStyle(color:subCategoryField==true?Colors.black:Colors.red, fontSize: 16,fontWeight: FontWeight.w800),
          ),
        ));

  }

  void initialiaze() {

     priceCTRL =TextEditingController();
     productNameCTRL =TextEditingController();
     quantityCTRL =TextEditingController();

  }


}