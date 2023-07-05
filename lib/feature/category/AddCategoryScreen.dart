import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hisab_kitab/feature/category/bloc/CategoryBloc.dart';
import 'package:hisab_kitab/feature/category/bloc/CategoryEvent.dart';
import 'package:hisab_kitab/feature/category/bloc/CategoryState.dart';
import 'package:hisab_kitab/feature/category/model/CategoriesModel.dart';
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
  var selectedSequence;
  bool categoryField=true;
  final categoryBloc=CategoryBloc();

  @override
  void initState() {
    categoryBloc.add(GetCategoryListEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context)
  {
  return Scaffold(
    resizeToAvoidBottomInset: false,

    backgroundColor: Colors.grey.shade100,
    body:SingleChildScrollView(
      child:SizedBox(
        //height: MediaQuery.of(context).size.height*3,
        height:double.maxFinite,
        child:Column(
          children: [
            getCategoriesForm(),
            getCategoriesList()
          ],
        ),
      ),
    )
  );
  }

  getCategoryField() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).copyWith(top: 10),
        child: TextFormField(
          controller:categoryCtrl,
          autovalidateMode: AutovalidateMode.disabled,autofocus: false,
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

                  print("REQ ${request}");

                  var provider=Provider.of<LoaderNotifier>(context,listen: false);
                  provider.loading=true;
                  await provider.postData(baseUrl: ApiProvider.baseUrl,
                      endApi:EndPoint.saveCategory,request:json.encode(request));
                  print("REQ ${request}");
                  if(provider.isBack){
                    provider.loading=false;
                    ReusableWidgets.showToast(msg:StringResources.categoryAddSuccess, type: true);

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
  }

  getCategoriesList() {
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
              return ReusableWidgets.getShimerListVertical(context);
            }
            else if(state is CategoryLoading){
              return ReusableWidgets.getShimerListVertical(context);

            }
            else if(state is CategoryLoaded){

              print("fffffffffy6666666"+state.categoriesModel.toJson().toString());
              List<ListItems>?listCategories=state.categoriesModel.list;
              return ListView.builder(
                  itemCount:listCategories?.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  //primary: false,
                  itemBuilder: (context,index){
                    return Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: (){

                        },
                        child: Container(
                            margin: EdgeInsets.only(left: 6,right: 6,top: 5,bottom: 5),
                            padding: EdgeInsets.all(14),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            height: 55,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.categoriesModel!.list![index]!.categoryName.toString(),style:GoogleFonts.poppins(fontSize: 14,
                                  fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.9),)
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                        onPressed:(){}, icon:Icon(Icons.edit,
                                      color: ColorResources.primaryColor,size: 25,)),
                                    IconButton(
                                        onPressed:(){}, icon:Icon(Icons.delete,
                                      color: Colors.red.shade500,size: 25,)),
                                  ],
                                )
                              ],
                            )
                        ),
                      ),
                    );
                  });
            }
            else{
              return const Text("no data");
            }
          }),
        ));
  }

  getCategoriesForm() {
   return Stack(
      children: [
        Container(
          //height: 300,
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
              submitButton(),
              Container(
                margin: EdgeInsets.only(top: 10,bottom: 8),
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
    );
  }

}