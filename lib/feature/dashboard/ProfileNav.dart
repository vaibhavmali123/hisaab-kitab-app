import 'package:flutter/material.dart';

import '../category/AddCategoryScreen.dart';

class ProfileNav extends StatefulWidget{

  State<ProfileNav> createState()=>ProfileNavState();
}

class ProfileNavState extends State<ProfileNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 100,),
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.green,
              child: Icon(Icons.account_circle,size: 80,),
            ),
            SizedBox(height: 30,),
            Container(height: 1,color: Colors.black26,width: double.infinity,),

            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: ListTile(title: Text("Edit profile"),leading: Icon(Icons.edit,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),),
            ),
            SizedBox(height: 8,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: ListTile(title: Text("Contact us"),leading: Icon(Icons.contact_mail,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),),
            ),

            SizedBox(height: 8,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: ListTile(title: Text("Add category"),leading: Icon(Icons.add_business_rounded,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),
              onTap: (){
                navigate("addCat");
              },
              ),
            ),

            SizedBox(height: 8,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: ListTile(title: Text("Update/ delete category"),leading: Icon(Icons.edit_note,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),),
            ),

            SizedBox(height: 8,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: ListTile(title: Text("Add subcategory"),leading: Icon(Icons.add_business_rounded,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),),
            ),

            SizedBox(height: 8,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: ListTile(title: Text("Update/ delete subcategory"),leading: Icon(Icons.edit_note,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),),
            ),
            SizedBox(height: 8,),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width/1.1,
              decoration: BoxDecoration(color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
              ),
              child: ListTile(title: Text("Privacy policies"),leading: Icon(Icons.policy,color: Colors.black87,size: 20,),trailing: Icon(Icons.arrow_forward_ios_rounded,color: Colors.black87,size: 20,),),
            )






          ],
        ),
      )
    );
    throw UnimplementedError();
  }

  void navigate(String type) {
    switch(type){


      case "addCat":
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return AddCategoryScreen();
        }));
        break;
    }

  }
}