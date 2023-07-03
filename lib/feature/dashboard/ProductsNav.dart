import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hisab_kitab/feature/subcategory/model/SubcategoriesModel.dart';
import 'package:hisab_kitab/utils/StringResources.dart';
import 'package:flutter/services.dart';
import 'package:hisab_kitab/feature/category/model/CategoriesModel.dart';

import '../../utils/ReusableWidgets.dart';
import '../../utils/colors.dart';
import '../category/bloc/CategoryBloc.dart';
import '../category/bloc/CategoryEvent.dart';
import '../category/bloc/CategoryState.dart';
import 'package:hisab_kitab/feature/subcategory/bloc/SubcategoriesBloc.dart';
import '../../utils/colors.dart';
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
import '../subcategory/bloc/SubcateggoryState.dart';
import '../subcategory/bloc/SubcategoryEvent.dart';
class ProductsNav extends StatefulWidget{

  State<ProductsNav> createState()=>ProductsNavState();
}

class ProductsNavState extends State<ProductsNav> {
String? selectedCategory,selectedSubCategory;
List<String> categoryList=["mobile","Cover","charger"];
List<String> subCategoryList=["redmi","samsung"];
TextEditingController? productNameCtrl,priceEditingController,quantityEditingController;
final categoryBloc=CategoryBloc();
late int selectedCategoryId,selectedSubCategoryId=0;
final subCategoriesBloc=SubcategoriesBloc();
var provider;
List<ListElemet>listSubCategories=[];
  @override
  void initState() {
    // TODO: implement initState
    categoryBloc.add(GetCategoryListEvent());
    super.initState();
    initialize();
  }
  @override
  Widget build(BuildContext context) {
    provider=Provider.of<LoaderNotifier>(context,listen: false);
    provider.loading=false;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(child: SingleChildScrollView(
        child:Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
//          height: MediaQuery.of(context).size.height/2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 8),

                  Text(StringResources.addProducts,style: Theme.of(context).primaryTextTheme.headline2,),
                  SizedBox(height: 8),

                  getCategoryDropDown(),
                  //SizedBox(height: 5),

                  getSubcategoryDropdown(),
                  //SizedBox(height: 20),

                  getProductField(),
                  //SizedBox(height: 20),
                  getPriceField(),
                  //SizedBox(height: 20),
                  getQuantityField(),
                  SizedBox(height: 12),
                  submitButton()
                ],
              ),
            ),
            Consumer<LoaderNotifier>(builder:(context,data,child){
              return data.loading?ReusableWidgets.loader:Container();
            })
          ],
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
  return BlocProvider(
      create: (_)=>categoryBloc,
      child:BlocListener<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategoryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message!),
              ),
            );
          }
        },
        child:BlocBuilder<CategoryBloc,CategoryState>(builder:(context,state){
          if(state is CategoryInitial){
            return Center(child: LinearProgressIndicator(),);
          }
          else if(state is CategoryLoading){
            return Center(child: LinearProgressIndicator(),);

          }
          else if(state is CategoryLoaded){

            // print("fffffffffy6666666"+state.categoriesModel.statusCode);
            List<ListItems>?listCategories=state.categoriesModel.list;
            return Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 10),
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 1,color: Colors.black87)
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
                      items: listCategories?.map<DropdownMenuItem<String>>((ListItems value) {
                        return DropdownMenuItem<String>(
                          value: value.categoryName,
                          child: Text(
                            value.categoryName.toString()==null?"ggg":value.categoryName.toString(),
                            style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                          ),
                        );
                      }).toList(),
                      hint: Text(
                        "Select category",
                        style: TextStyle(fontSize: 14,  color:Colors.black54, fontWeight: FontWeight.w400),
                      ),
                      onChanged: (String? value)
                      {
                        state.categoriesModel.list?.map((e) {
                          if(e.categoryName!.contains(value.toString())){

                            setState(() {
                              selectedCategoryId=e.categoryId;

                            });
                          }
                        }).toList();
                        setState((){
                          selectedCategory=value;
                          listSubCategories.clear();
                          selectedSubCategory=null;
                        });
                        subCategoriesBloc.add(GetSubcategoryevent(selectedCategoryId));
                      },
                    ),
                  ),
                ),
              ),
            );
          }
          else{
            return Container(
              child: Text("no data"),
            );


          
          }
        }),
      ));
  }

  getSubcategoryDropdown() {
    return selectedCategory!=null?BlocProvider(
        create: (_)=>subCategoriesBloc,
        child:BlocListener<SubcategoriesBloc, SubcateggoryState>(
          listener: (context, state) {
            if (state is CategoryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Error"),
                ),
              );
            }
          },
          child:BlocBuilder<SubcategoriesBloc,SubcateggoryState>(builder:(context,state){
            if(state is SubcategoryInitial){
              return Center(child: CircularProgressIndicator(),);
            }
            else if(state is SubcategoryLoading){
              return Center(child: CircularProgressIndicator(),);

            }
            else if(state is SubcategoryLoaded){

              // print("fffffffffy6666666"+state.categoriesModel.statusCode)
              listSubCategories=state.suubcategoriesModel.list;
              return listSubCategories!=null?MediaQuery.removePadding(context: context, child:
              Padding(padding: EdgeInsets.only(left: 15,right: 15,top: 10),
                child: Container(
                    alignment: Alignment.centerLeft,
                    height: 48,
                    width: double.infinity,
                    child:Container(
                      height: 54,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(width: 1,color: Colors.black87)
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
                            items: listSubCategories.map<DropdownMenuItem<String>>((ListElemet value) {
                              return DropdownMenuItem<String>(
                                value: value.subCategoryName,
                                child: Text(
                                  value.subCategoryName,
                                  style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Select SubCategory",
                              style: TextStyle(fontSize: 14,  color:Colors.black54, fontWeight: FontWeight.w400),
                            ),
                            onChanged: (String? value)
                            {
                              state.suubcategoriesModel.list.map((e) {
                                if(e.subCategoryName.contains(value.toString())){

                                  setState(() {
                                    selectedSubCategoryId=e.subCategoryId;

                                  });
                                }
                              }).toList();
                              setState((){
                                selectedSubCategory=value;
                              });
                            },
                          ),
                        ),
                      ),
                    )
                ),
              ),removeTop: true,):Container();
            }
            else{
              return Container(
                child: Text("no data"),
              );
            }
          }),
        )):SizedBox(width: 0,height: 0,);
  }

  getProductField() {
    return Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
        child: TextFormField(
          controller:productNameCtrl,
          autovalidateMode: AutovalidateMode.disabled,
          style: TextStyle(color: Colors.black, fontSize: 14),
          decoration: InputDecoration(
            border: ReusableWidgets.inputBorder,
            enabledBorder:ReusableWidgets.inputBorder,
            focusedBorder:ReusableWidgets.focusedInputBorder,
            // hintText: StringResources.enterProductNameField,
            labelText:StringResources.enterProductNameField,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.only(bottom: 6,left: 10),
            floatingLabelStyle:TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),
            hintStyle: TextStyle(color:Colors.black, fontSize: 16,fontWeight: FontWeight.w800),

          ),
        ));
  }

  getPriceField() {
    return Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
        child: TextFormField(
          controller:priceEditingController,
          keyboardType: TextInputType.number,
          autovalidateMode: AutovalidateMode.disabled,
          style: TextStyle(color: Colors.black, fontSize: 14),
          decoration: InputDecoration(
            border: ReusableWidgets.inputBorder,
            enabledBorder:ReusableWidgets.inputBorder,
            focusedBorder:ReusableWidgets.focusedInputBorder,
            // hintText: StringResources.enterProductNameField,
            labelText:StringResources.enterProductPriceField,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.only(bottom: 6,left: 10),
            floatingLabelStyle:TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),
            hintStyle: TextStyle(color:Colors.black, fontSize: 16,fontWeight: FontWeight.w800),

          ),
        ));
  }

  getQuantityField() {
    return Padding(
        padding: const EdgeInsets.only(left: 15,right: 15,top: 12),
        child: TextFormField(
          controller:quantityEditingController,
          keyboardType:TextInputType.number,
          autovalidateMode: AutovalidateMode.disabled,
          style: TextStyle(color: Colors.black, fontSize: 14),
          decoration: InputDecoration(
            border: ReusableWidgets.inputBorder,
            enabledBorder:ReusableWidgets.inputBorder,
            focusedBorder:ReusableWidgets.focusedInputBorder,
            // hintText: StringResources.enterProductNameField,
            labelText:StringResources.enterProductQTYField,
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            contentPadding: EdgeInsets.only(bottom: 6,left: 10),
            floatingLabelStyle:TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),
            hintStyle: TextStyle(color:Colors.black, fontSize: 16,fontWeight: FontWeight.w800),

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
                print("REQ:");
                var request={
                  "categoryId":selectedCategoryId,
                  "subCategoryId":selectedSubCategoryId!=null?selectedSubCategoryId:0,
                  "productName":productNameCtrl?.text,
                  "updatedDate":DateTime.now().toString(),
                  "price":priceEditingController?.text
                };
                if(selectedCategory!=null && productNameCtrl!.text.isNotEmpty
                    && priceEditingController!.text.isNotEmpty && quantityEditingController!.text.isNotEmpty){

                  await provider.postData(baseUrl: ApiProvider.baseUrl, endApi:EndPoint.saveProduct,request:json.encode(request));
                  if(provider.isBack){
                    productNameCtrl!.clear();
                    priceEditingController!.clear();
                    quantityEditingController!.clear();
                    ReusableWidgets.showToast(msg: "Product added successfully", type: true);
                  }
                }
                print("REQ: ${request.toString()}");

              }, child: Text('Submit',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            ),
          )
        ],
      );
  }
}