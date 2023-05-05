import 'package:flutter/material.dart';

import '../category/AddCategoryScreen.dart';

class CategoryMaster extends StatefulWidget
{

  CategoryMasterState createState()=>CategoryMasterState();
}
class CategoryMasterState extends State <CategoryMaster>{
  @override
  Widget build(BuildContext context)
  {
  return Scaffold(
    body: AddCategoryScreen(),
  );
  }
}