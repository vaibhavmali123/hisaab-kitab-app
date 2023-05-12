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
  var provider;
  TextEditingController subcategoryCtrl=TextEditingController();
   TextEditingController categoryCtrl=TextEditingController();
  String? selectedCategory,selectedSubCategory;
  List<String> categoryList=["mobile","Cover","charger"];
  bool subCategoryField=true;
  int? selectedCategoryId;
final categoryBloc=CategoryBloc();

  @override
  void initState() {
    // TODO: implement initState
    categoryBloc.add(GetCategoryListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context)
  {
   provider=Provider.of<LoaderNotifier>(context,listen: false);
    provider.loading=false;
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
                    SizedBox(height: 12,),
                    getSubCategoryField(),
                    SizedBox(height: 15,),
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

  submitButton() {
    return SizedBox(
      height: 47,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width/1.1,
        color: ColorResources.primaryColor,
        onPressed: ()async{
          print("EER ${selectedCategoryId} ${subcategoryCtrl.text}");
        if(selectedCategoryId!=null && subcategoryCtrl.text!=""){
          var request={
            "categoryId":selectedCategoryId,
            "subCategoryName":subcategoryCtrl.text
          };
          print("REQ ${request}");

          await provider.postData(baseUrl: ApiProvider.baseUrl, endApi:EndPoint.addSubCategory,request:json.encode(request));
          if(provider.isBack){

            ReusableWidgets.showToast(msg: "Subcategory added successfully", type: true);
    }
    }
        else{
          ReusableWidgets.showToast(msg: "Please enter details", type: false);
        }
        }, child: Text('Submit',
          style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.bold)),
      ),
    );
  }
   getSubCategoryField() {
     return Padding(
         padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
         child: TextFormField(
           controller:subcategoryCtrl,
           autovalidateMode: AutovalidateMode.disabled,
           style: TextStyle(color: Colors.black, fontSize: 14),
           decoration: InputDecoration(
             border: ReusableWidgets.inputBorder,
             enabledBorder:ReusableWidgets.inputBorder,
             focusedBorder:ReusableWidgets.focusedInputBorder,
             errorBorder:ReusableWidgets.focussedErrorInputBorder,
             focusedErrorBorder:ReusableWidgets.focussedErrorInputBorder,
             // hintText: StringResources.enterProductNameField,
             labelText:StringResources.entersubcategoryNameField,
             floatingLabelAlignment: FloatingLabelAlignment.start,
             floatingLabelBehavior: FloatingLabelBehavior.auto,
             contentPadding: EdgeInsets.only(bottom: 6,left: 10),
             floatingLabelStyle:TextStyle(color: Colors.black, fontSize: 15,fontWeight: FontWeight.w700),
             hintStyle: TextStyle(color:Colors.black, fontSize: 16,fontWeight: FontWeight.w800),

           ),
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
              return const Center(child: CircularProgressIndicator(),);
            }
            else if(state is CategoryLoading){
              return Center(child: CircularProgressIndicator(),);

            }
            else if(state is CategoryLoaded){

             print("fffffffffy6666666"+state.categoriesModel.toJson().toString());
            List<ListItems>?listCategories=state.categoriesModel.list;
              return Padding(padding: EdgeInsets.symmetric(horizontal: 15),
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