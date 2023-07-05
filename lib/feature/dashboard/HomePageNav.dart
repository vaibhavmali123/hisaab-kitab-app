import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/feature/customer/model/CustomerModel.dart';
import 'package:hisab_kitab/feature/customer/ui/CustomerPage.dart';
import 'package:hisab_kitab/feature/cart/CartModel.dart';
import 'package:hisab_kitab/feature/cart/ui/CartPage.dart';
import 'package:hisab_kitab/feature/products/model/ProductsModel.dart';
import 'package:hisab_kitab/utils/ReusableWidgets.dart';
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
import 'package:hisab_kitab/feature/cart/ProductSelectionBloc.dart';
import 'package:hisab_kitab/feature/cart/CartEvent.dart';
import 'dart:convert';
import 'package:hisab_kitab/feature/cart/CartState.dart';
class HomePageNav extends StatefulWidget{

  State<HomePageNav> createState()=>HomePageNavState();
}

class HomePageNavState extends State<HomePageNav> {

  final subCategoriesBloc=SubcategoriesBloc();
  final productsBloc=ProductsBloc();
  Customer? customer;
  final productSelectionBloc=ProductSelectionBloc();
  List<ListElemet>listSubCategories=[];
   List<ProductsList>productsCartList=[];
  List<dynamic>productIdList=[];
  List<dynamic>productQuantityList=[];
  int? selectedCategoryId;
  int? selectedSubCategoryId=0;
  int? selectedIndex;
  String? selectedSubCategory;
  final categoryBloc=CategoryBloc();
  List<CartModel>cartList=[];

  @override
  void initState() {
    // TODO: implement initState
    selectedCategoryId=75;
    categoryBloc.add(GetCategoryListEvent());
    productsBloc.add(GetProductsListEvent(75,26));
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      floatingActionButton: getFloatingButton(context),
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
      toolbarTextStyle: const TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.black87),
      // toolbarHeight: 40,
      pinned: true,
      title: const Text("Hisaab kitab"),
      titleTextStyle: const TextStyle(fontWeight: FontWeight.w800,fontSize: 18,color: Colors.black87),
      centerTitle: false,
      leading: IconButton(onPressed: (){
        Scaffold.of(context).openDrawer();
      }, icon: const Icon(Icons.menu_rounded,color: Colors.black87,size: 30,)),
      actions: [
        Padding(padding: EdgeInsets.only(right: 12),

        child: Icon(Icons.document_scanner_sharp,color: Colors.black54,),)
      ],flexibleSpace
      : FlexibleSpaceBar(
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
                        return ReusableWidgets.getShimerHorizantalList(context);
                      }
                      else if(state is CategoryLoading){
                        return ReusableWidgets.getShimerHorizantalList(context);

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
                                   productsBloc.add(GetProductsListEvent(selectedCategoryId!,0));

                                  },
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: selectedIndex==index?Colors.black87:Colors.black45,width: 1),
                                        borderRadius: BorderRadius.all(Radius.circular(6)),
                                        color: ColorResources.primaryColor
                                    ),
                                    child: Center(
                                      child: Text(listCategories![index]!.categoryName.toString(),style: GoogleFonts.poppins(fontWeight: index==selectedIndex?FontWeight.w600: FontWeight.w500,color:index==selectedIndex?Colors.black87: Colors.black54,fontSize:index==selectedIndex?14:13),),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }
                      else{
                        return const Text("no data");
                      }
                    }),
                  ))),
SizedBox(
  height:45,
  child:
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(padding:EdgeInsets.only(top:2,left: 2),
      child: InkWell(
        onTap: ()async{
          customer=await Navigator.push(context, MaterialPageRoute(builder:(context){
            return CustomerPage();
          }));
          print("RESULT: ${customer?.name}");
          setState(() {
          });
        },
        child: Row(children:  [Icon(Icons.person,color: Colors.green,),
          Text(customer!=null?customer!.name:"Select customer",style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),)],),),),
      Flexible(child: getSubcategoryDropdown())
    ],
  ),
),

          getProductsList()
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
                const SnackBar(
                  content: Text("Error"),
                ),
              );
            }
          },
          child:BlocBuilder<SubcategoriesBloc,SubcateggoryState>(builder:(context,state){
            if(state is SubcategoryInitial){
              return ReusableWidgets.getSubcategoryDropdownShimmer();
            }
            else if(state is SubcategoryLoading){
              return ReusableWidgets.getSubcategoryDropdownShimmer();
            }
            else if(state is SubcategoryLoaded){

              // print("fffffffffy6666666"+state.categoriesModel.statusCode)
              listSubCategories=state.suubcategoriesModel.list;
              return listSubCategories!=null?MediaQuery.removePadding(context: context,removeTop: true, child:
              Padding(padding: EdgeInsets.only(left: 15,right: 5,top: 4),
                child:Container(
                     width:MediaQuery.of(context).size.width/2,
                    child:Container(
                      // height: 54,
                      decoration: const BoxDecoration(),
                      child: Center(
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              canvasColor: Colors.white,
                              buttonTheme: ButtonTheme.of(context).copyWith(
                                alignedDropdown: true, //If false (the default), then the dropdown's menu will be wider than its button.
                              )),
                          child: DropdownButton<String>(
                            elevation: 10,
                            isExpanded: false,
                            focusColor: Colors.white,
                            value: selectedSubCategory,
                            style: const TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.green,
                            icon:const Icon(Icons.filter_alt),
                            items: listSubCategories.map<DropdownMenuItem<String>>((ListElemet value) {
                              return DropdownMenuItem<String>(
                                value: value.subCategoryName,
                                child: Text(
                                  value.subCategoryName,
                                  style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                                ),
                              );
                            }).toList(),
                            hint: const Text(
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
                                  productsBloc.add(GetProductsListEvent(selectedCategoryId!,selectedSubCategoryId==null?0:selectedSubCategoryId!));

                            },
                          ),
                        ),
                      ),
                    )
                ),
              ),):Container();
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

  getProductsList() {
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
            return ReusableWidgets.getShimerListVertical(context);
          }
        else if(state is ProductsLoadingState){
          return ReusableWidgets.getShimerListVertical(context);
        }
        else if(state is ProductsLoadedState){
          return Padding(padding: EdgeInsets.only(bottom:55),child:
          state.productsModel.list.length>0?ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: state.productsModel.list.length,
              primary: false,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder:(context,index){
                productQuantityList.add(0);
                return GestureDetector(
                    onTap: (){

                    },
                    child:Container(
                        margin: EdgeInsets.only(left: 6,right: 6,top: 5,bottom: 5),
                        padding: EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                        ),
                        //height: 75,
                        child:Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.productsModel.list[index].productName,style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.9),)
                                ),
                                RichText(text:
                                TextSpan(text: "In stock:",style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.7)),
                                    children: <TextSpan>[
                                      TextSpan(text: state.productsModel.list[index].quantity.toString(),style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                    ]
                                ),)
                              ],
                            ),
                            SizedBox(height: 15,),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(text:
                                  TextSpan(text: "Price:",style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color:Colors.black87.withOpacity(0.7)),
                                      children: <TextSpan>[
                                        TextSpan(text: state.productsModel.list[index].price.toString(),style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                      ]
                                  ),),
                                  Container(
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          child: Container(decoration: BoxDecoration(
                                            color: ColorResources.primaryColor,
                                            shape:BoxShape.circle,
                                          ),
                                              child:Icon(Icons.remove)
                                          ),
                                          onTap: (){
                                            if(productQuantityList[index]!=0){
                                              productQuantityList[index]=productQuantityList[index]-1;
                                              setState(() {
                                              });
                                              removeFromCart(index,context,state);
                                            }
                                          },
                                        ),
                                        SizedBox(width:14 ,),
                                        RichText(text:
                                        TextSpan(
                                            children: <TextSpan>[
                                              TextSpan(text:
                                              productQuantityList[index].toString(),style:GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w400,color:Colors.black54) )
                                            ]
                                        ),),SizedBox(width: 14,),
                                        GestureDetector(
                                          child:Container(decoration: BoxDecoration(
                                            color: ColorResources.primaryColor,
                                            shape:BoxShape.circle,
                                          ),
                                              child:Icon(Icons.add)
                                          ),
                                          onTap: (){
                                            productQuantityList[index]=productQuantityList[index]+1;
                                            setState(() {
                                            });
                                            addToCart(index,context,state);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                            )
                          ],
                        )
                    )
                );
              }):Container(
            child: Container(
              height: MediaQuery.of(context).size.height/2,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text("No products found for selected category"),
                  )
                ],
              ),
            ),
          ),);
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
  Widget getFloatingButton(BuildContext context) {
    return BlocProvider(create:(_)=>productSelectionBloc,
    child: BlocListener<ProductSelectionBloc,CartState>(listener:(context,state){
      if(state is ProductsError)
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error"),
          ),
        );
      }
    },
    child: BlocBuilder<ProductSelectionBloc,CartState>(builder:(context,state){
      if(state is ProductsSelectionState){
        return state.cartList.length>0?SizedBox(
          width: 70,height: 45,
          child: FloatingActionButton(
              shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.5)
              ),
              onPressed: () async {
               final result=await Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage(state)));
                print("FLAG ${result}");
                if(result==0){
                  clearCartValues();
                }
              },backgroundColor: Colors.green,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text(state.cartList.length.toString(),style: TextStyle(fontWeight:FontWeight.w500,fontSize: 13),),
                  Icon(Icons.arrow_forward,size: 22,)
                ],)
          ),
        ):Container();
      }
      else{
        return Container();
      }
    },),
    ),
    );
  }

  CartModel? cartModel=null;
  void addToCart(int index, BuildContext context, ProductsLoadedState state) {
    print("Add to cart start:-------------- ${productIdList.length}");
    setState(() {
      cartModel=null;
    });
    cartModel = CartModel(
        productId: state.productsModel.list[index].productId,
        quantity:productQuantityList[index],
        inStockQTY: state.productsModel.list[index].quantity,
        productName: state.productsModel.list[index].productName,
        comment: state.productsModel.list[index].comment,
        price: state.productsModel.list[index].price,
        productImage: state.productsModel.list[index].productImage,
        categoryId: state.productsModel.list[index].categoryId,
        createdDate: state.productsModel.list[index].createdDate,
        updatedDate: state.productsModel.list[index].updatedDate);

    productSelectionBloc.add(AddToCartEvent(cartModel!));
    //productSelectionBloc.add(UpdateQuantity(cartModel!));
setState(() {

});

    }

  void removeFromCart(int index, BuildContext context, ProductsLoadedState state) {

    cartModel = CartModel(
        productId: state.productsModel.list[index].productId,
        quantity:productQuantityList[index],
        inStockQTY: state.productsModel.list[index].quantity,
        productName: state.productsModel.list[index].productName,
        comment: state.productsModel.list[index].comment,
        price: state.productsModel.list[index].price,
        productImage: state.productsModel.list[index].productImage,
        categoryId: state.productsModel.list[index].categoryId,
        createdDate: state.productsModel.list[index].createdDate,
        updatedDate: state.productsModel.list[index].updatedDate);

    productSelectionBloc.add(RemoveFromCartEvent(cartModel!));
setState(() {

});
  }

  void clearCartValues() {
    productSelectionBloc.add(ClearCartEvent());
    productsBloc.add(GetProductsListEvent(75,26));
    for(int i=0;i<productQuantityList.length;i++){
      if(productQuantityList[i]>0){
        print("FLAG productQuantityList ${productQuantityList[i]}");
        productQuantityList[i]=0;
      }
    }

    setState(() {
    });
    print("FLAG productQuantityList ${productQuantityList}");
  }
  }


