import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hisab_kitab/utils/StringResources.dart';
import 'package:flutter/services.dart';

class ProductsNav extends StatefulWidget{

  State<ProductsNav> createState()=>ProductsNavState();
}

class ProductsNavState extends State<ProductsNav> {
String? selectedCategory,selectedSubCategory;
List<String> categoryList=["mobile","Cover","charger"];
List<String> subCategoryList=["redmi","samsung"];
TextEditingController? productNameCtrl,priceEditingController,quantityEditingController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: SingleChildScrollView(
        child:Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/1.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 20),

              Text(StringResources.addProducts,style: Theme.of(context).primaryTextTheme.headline2,),
              SizedBox(height: 20),

              getCategoryDropDown(),
              SizedBox(height: 5),
              getSubcategoryDropdown(),
              //SizedBox(height: 20),

              getProductField(),
              //SizedBox(height: 20),
              getPriceField(),
              //SizedBox(height: 20),
              getQuantityField(),
              SizedBox(height: 5),
              submitButton()
            ],
          ),
        ),
      )),
    );
    throw UnimplementedError();
  }

  void initialize() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white, // navigation bar color
      statusBarColor: Colors.white,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark// status bar color
    ));

    productNameCtrl=TextEditingController();
    priceEditingController=TextEditingController();
    quantityEditingController=TextEditingController();
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

  getProductField() {
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
              controller:productNameCtrl,

              style: TextStyle(color: Colors.black, fontSize: 14),
              decoration: InputDecoration(
                border: InputBorder.none,
                // hintText: StringResources.enterProductNameField,
                labelText:StringResources.enterProductNameField,
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

  getPriceField() {
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
            child: TextField(
              controller:priceEditingController,
              style: TextStyle(color: Colors.black, fontSize: 14),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
              //  hintText: StringResources.enterProductPriceField,
                hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                labelText:StringResources.enterProductPriceField,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: EdgeInsets.only(bottom: 6),
                floatingLabelStyle:TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),

              ),
            ),
          ),
        ));
  }

  getQuantityField() {
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
            child: TextField(
              controller:quantityEditingController,
              style: TextStyle(color: Colors.black, fontSize: 14),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                //hintText: StringResources.enterProductQTYField,
                hintStyle: TextStyle(color: Colors.black, fontSize: 14),
                labelText:StringResources.enterProductQTYField,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: EdgeInsets.only(bottom: 6),
                floatingLabelStyle:TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),

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