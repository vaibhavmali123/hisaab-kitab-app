import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:hisab_kitab/feature/category/CategoryRepository.dart';
import 'package:hisab_kitab/feature/category/model/CategoriesModel.dart';
import '../../utils/StringResources.dart';
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

import '../category/bloc/CategoryBloc.dart';
import '../category/bloc/CategoryEvent.dart';
import '../category/bloc/CategoryState.dart';
class AddSubcategoryScreen extends StatefulWidget
{

  State createState()=>AddSubcategoryScreenState();
}

class AddSubcategoryScreenState extends State<AddSubcategoryScreen>
{
  TextEditingController subcategoryCtrl=TextEditingController();
  String? selectedCategory,selectedSubCategory;
  List<String> categoryList=["mobile","Cover","charger"];
  bool subCategoryField=true;
final categoryBloc=CategoryBloc();

  @override
  void initState() {
    // TODO: implement initState
    categoryBloc.add(GetCategoryListEvent());
    super.initState();
    //Object categoriesModel=CategoryRepository.fetchCategories(baseUrl: ApiProvider.baseUrl, endApi:EndPoint.getAllCategories);
    //print("RESPONSE dd ${categoriesModel.toString()}");

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
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    getCategoryDropDown(),
                    SizedBox(height: 17,),
                    getSubCategoryField(),
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

  getSubCategoryField() {
    return Container();
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
            "categoryId":'1',
            "subCategoryName":"hhhhh"
          };

          await provider.postData(baseUrl: ApiProvider.baseUrl, endApi:EndPoint.addSubCategory,request:json.encode(request));
          if(provider.isBack){
            Navigator.pop(context);
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
              return Center(child: CircularProgressIndicator(),);
            }
            else if(state is CategoryLoading){
              return Center(child: CircularProgressIndicator(),);

            }
            else if(state is CategoryLoaded){
              print("fffffffffy6666666");
              return Padding(padding: EdgeInsets.symmetric(horizontal: 18),
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
                              "Select subcategory"+state.categoriesModel.statusCode,
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
            else{
              return Container(
                child: Text("no data"),
              );
            }
          }),
        ));
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
              return Center(child: CircularProgressIndicator(),);
            }
            else if(state is CategoryLoading){
              return Center(child: CircularProgressIndicator(),);

            }
            else if(state is CategoryLoaded){
              print("fffffffffy6666666");
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
                              "Select category"+state.categoriesModel.statusCode,
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
            else{
              return Container(
                child: Text("no data"),
              );
            }
          }),
        ));

  }

}