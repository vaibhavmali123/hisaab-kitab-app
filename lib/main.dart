import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/MyApp.dart';
import 'package:hisab_kitab/utils/LoadingNotifier.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=>LoaderNotifier())
      ],
          child:DevicePreview(
            builder: (context)=>MyApp(),
          )
      ),
      );
}

//MyApp()
