import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../category/bloc/CategoryBloc.dart';
import '../category/bloc/CategoryEvent.dart';
import '../category/bloc/CategoryState.dart';
import '../category/model/CategoriesModel.dart';
import '../subcategory/bloc/SubcateggoryState.dart';
import '../subcategory/bloc/SubcategoriesBloc.dart';
import '../subcategory/bloc/SubcategoryEvent.dart';
import '../subcategory/model/SubcategoriesModel.dart';
import 'package:hisab_kitab/feature/products/bloc/ProductsBloc.dart';
import 'package:hisab_kitab/feature/products/bloc/ProductsEvent.dart';
import 'package:hisab_kitab/feature/products/bloc/ProductsState.dart';
class HomePageNav extends StatefulWidget{

  State<HomePageNav> createState()=>HomePageNavState();
}

class HomePageNavState extends State<HomePageNav> {

  final subCategoriesBloc=SubcategoriesBloc();
  final productsBloc=ProductsBloc();
  List<ListElemet>listSubCategories=[];

  int? selectedCategoryId;
  int? selectedSubCategoryId;
  int? selectedIndex;
  String? selectedSubCategory;
  final categoryBloc=CategoryBloc();
  @override
  void initState() {
    // TODO: implement initState
    selectedCategoryId=75;
    categoryBloc.add(GetCategoryListEvent());
    productsBloc.add(GetProductsListEvent(75,26));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        child: CustomScrollView(
          slivers:[
             getSliverAppbar(),
            getSliverBoxGrid()
          ],
        ),
      ),
    );
  }

  Widget getSliverAppbar(){
    return SliverAppBar(
      backgroundColor:Colors.white,
      expandedHeight: 160,
      floating: true,
      toolbarTextStyle: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.black87),
      // toolbarHeight: 40,
      pinned: true,
      title: Text("Hisaab kitab"),
      titleTextStyle: TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.black87),
      centerTitle: false,
      leading: IconButton(onPressed: (){
        Scaffold.of(context).openDrawer();
      }, icon: Icon(Icons.menu,color: Colors.black87,)),
      actions: [
        Padding(padding: EdgeInsets.only(right: 12),

        child: Icon(Icons.document_scanner_sharp,color: Colors.black54,),)
      ],
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        background:
        SafeArea(
          child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 45,),
              getHeader()
            ],
          ),

        ),
      ),
    );
  }
  Widget getSliverBoxGrid() {
    return SliverToBoxAdapter(
      child:
      Padding(padding: EdgeInsets.symmetric(horizontal: 3),
      child: MediaQuery.removePadding(
          removeTop: true,
          context: context, child:Column(
        children: [
          SizedBox(
            height: 35,
              width: double.infinity,
              child:
              BlocProvider(
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

                         print("fffffffffy6666666"+state.categoriesModel.toJson().toString());
                        List<ListItems>?listCategories=state.categoriesModel.list;
                        return ListView.builder(
                            itemCount:listCategories?.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            //primary: false,
                            itemBuilder: (context,index){
                              return Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  onTap: (){
                                   setState(() {
                                     selectedCategoryId=listCategories[index].categoryId;
                                      selectedIndex=index;
                                   });
                                   setState((){
                                     //selectedCategory=value;
                                     listSubCategories.clear();
                                     selectedSubCategory=null;
                                   });
                                   subCategoriesBloc.add(GetSubcategoryevent(selectedCategoryId!));

                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    child: Center(
                                      child: Text(listCategories![index]!.categoryName.toString(),style: GoogleFonts.poppins(fontWeight: index==selectedIndex?FontWeight.w600: FontWeight.w500,color:index==selectedIndex?Colors.black87: Colors.black54,fontSize:index==selectedIndex?14:13),),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: selectedIndex==index?Colors.black87:Colors.black45,width: 1),
                                        borderRadius: BorderRadius.all(Radius.circular(12)),
                                        color: ColorResources.primaryColor
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                      else{
                        return Container(
                          child: Text("no data"),
                        );
                      }
                    }),
                  ))),
SizedBox(
  height:45,
  child:           Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Flexible(child: getSubcategoryDropdown())
      /*Text("Select subcategory",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.black54,fontSize: 14),),
      IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_outlined),color: Colors.black87,)*/
    ],
  ),
),

          getProductsGrid()
          /*GridView.builder(
              itemCount: 25,
              primary:false,
              shrinkWrap:true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.width, crossAxisCount: 2),
              itemBuilder: (context,index){
                return  Container(
                    height: 130,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16),),
                    ),
                    child: Card(
                        child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              SizedBox(height: 10),
                              Image.asset("assets/mbl.png",fit: BoxFit.fill,height: 120,width: 100,),
                              Container(
                                width: double.infinity,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: ColorResources.primaryColor
                                ),
                                child: Center(
                                  child: Text("Mobile $index",style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w600),),
                                ),
                              )
                            ]
                        )
                    )
                );
              })*/
        ],
      )),
      ),
    );
  }
  getSubcategoryDropdown() {
    return selectedCategoryId!=null?BlocProvider(
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
              Padding(padding: EdgeInsets.only(left: 15,right: 5,top: 4),
                child:Container(
                    // height: 48,
                     width:MediaQuery.of(context).size.width/2,
                    child:Container(
                      // height: 54,
                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(6),
  //                        border: Border.all(width: 1,color: Colors.black87)
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
                            elevation: 10,
                            /*underline: Container(
                              height: 1.0,
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.transparent, width: 0.0))),
                            ),*/

                            isExpanded: false,
                            focusColor: Colors.white,
                            value: selectedSubCategory,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.green,
                            icon:Icon(Icons.filter_alt),
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

                              setState(() {
                                    selectedSubCategory=value;
                                  });
                                  productsBloc.add(GetProductsListEvent(selectedCategoryId!,selectedSubCategoryId!));

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
  getHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          width: MediaQuery.of(context).size.width/2.1,
          padding: EdgeInsets.only(left: 8),
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("200",style: GoogleFonts.poppins(fontSize: 21,color: Colors.black87,fontWeight: FontWeight.w700)),
              SizedBox(height: 6,),
              Text("Products in",style: GoogleFonts.poppins(fontSize: 18,color: Colors.black87,fontWeight: FontWeight.w800))
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(12),),
              gradient: LinearGradient(colors: [Colors.lightGreenAccent,ColorResources.primaryColor])
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width/2.1,
          padding: EdgeInsets.only(left: 8),
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("200",style: GoogleFonts.poppins(fontSize: 21,color: Colors.black87,fontWeight: FontWeight.w700)),
              SizedBox(height: 6,),
              Text("Products out",style: GoogleFonts.poppins(fontSize: 18,color: Colors.black87,fontWeight: FontWeight.w800))
            ],
          ),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(12),),
              gradient: LinearGradient(colors: [Colors.lightGreenAccent,ColorResources.primaryColor])
          ),
        ),
      ],
    );

  }

  getProductsGrid() {
    return BlocProvider(create: (_)=>productsBloc,
    child: BlocListener<ProductsBloc,ProductsState>(listener: (context,state){
      if(state is ProductsError)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message!),
            ),
          );
        }
    },
      child: BlocBuilder<ProductsBloc,ProductsState>(builder: (context,state){
        if(state is ProductsInitial)
          {
            return Center(child: CircularProgressIndicator(),);
          }
        else if(state is ProductsLoadingState){
          return Center(child: CircularProgressIndicator(),);
        }
        else if(state is ProductsLoadedState){
          return GridView.builder(
              itemCount: state.productsModel.list.length,
              primary:false,
              shrinkWrap:true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: MediaQuery.of(context).size.width/MediaQuery.of(context).size.width, crossAxisCount: 2),
              itemBuilder: (context,index){
                return  Container(
                    height: MediaQuery.of(context).size.height/4.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16),),
                    ),
                    child: Card(
                        child:Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              SizedBox(height: 10),
                              Image.asset("assets/mbl.png",fit: BoxFit.fill,height: 120,width: 100,),
                              Container(
                                width: double.infinity,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: ColorResources.primaryColor
                                ),
                                child: Center(
                                  child: Text(state.productsModel.list[index].productName,style: GoogleFonts.poppins(fontSize: 12,color: Colors.white,fontWeight: FontWeight.w600),),
                                ),
                              )
                            ]
                        )
                    )
                );
              });
        }
        else{
          return Container(
            child: Text("no data"),
          );
        }
      },),
    ),
    );
  }
}