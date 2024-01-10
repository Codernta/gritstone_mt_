import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:gritstone/HiveDB/hive_functions.dart';
import 'package:gritstone/HiveDB/hive_model.dart';
import 'package:gritstone/Providers/theme_provider.dart';
import 'package:gritstone/ThemeDatas/theme_data.dart';
import 'package:gritstone/Views/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  hiveInit();
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeProvider(), child: const MyApp()));
}


void hiveInit() async {
  Directory? appDocDirectory =    Platform.isAndroid ? await getExternalStorageDirectory() : await getApplicationDocumentsDirectory();
  var path = appDocDirectory!.path;
  Hive.init(path);
  await Hive.initFlutter();
  Hive.registerAdapter(AddTextAdapter());
  // await Hive.openBox('box1');--
  await Hive.openBox<AddTextModel>('add_text_db');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Machine Test',
      theme: Provider.of<ThemeProvider>(context).themeData,
      darkTheme: darkMode,
      home: const HomeScreen(),
    );
  }
}




