import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hisab_kitab/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../category/bloc/CategoryBloc.dart';
import '../category/bloc/CategoryEvent.dart';
import '../category/bloc/CategoryState.dart';
import '../category/model/CategoriesModel.dart';
class HomePageNav extends StatefulWidget{

  State<HomePageNav> createState()=>HomePageNavState();
}

class HomePageNavState extends State<HomePageNav> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
List<String>listtabs=[
  'Mobiles',
  'Chargers',
  'Covers',
  'Earphones',
  'parts',
  'Others'
];
  final categoryBloc=CategoryBloc();
  @override
  void initState() {
    // TODO: implement initState
    categoryBloc.add(GetCategoryListEvent());
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
              Row(
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
              )
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

                        // print("fffffffffy6666666"+state.categoriesModel.statusCode);
                        List<ListItems>?listCategories=state.categoriesModel.list;
                        return ListView.builder(
                            itemCount:listCategories?.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            //primary: false,
                            itemBuilder: (context,index){
                              return Padding(padding: EdgeInsets.symmetric(horizontal: 5),
                                child: GestureDetector(
                                  child: Container(
                                    height: 35,
                                    width: 100,
                                    child: Center(
                                      child: Text(listCategories[index]?.categoryName.toString(),style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.black54,fontSize: 13),),
                                    ),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black45,width: 1),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text("Select subcategory",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.black54,fontSize: 14),),
              IconButton(onPressed: (){}, icon: Icon(Icons.filter_alt_outlined),color: Colors.black87,)
            ],
          ),

          GridView.builder(
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
              })
        ],
      )),
      ),
    );
  }
}