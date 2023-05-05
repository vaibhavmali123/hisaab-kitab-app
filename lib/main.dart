
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/MyApp.dart';
import 'package:hisab_kitab/utils/LoadingNotifier.dart';
void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=>LoaderNotifier())
      ],
          child:MyApp()
      ),
      );
}


