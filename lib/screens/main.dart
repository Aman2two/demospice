import 'package:demo/network/ApiCall.dart';
import 'package:demo/screens/ItemsPage.dart';
import 'package:demo/screens/detail_screen.dart';
import 'package:demo/Models/model.dart';
import 'package:demo/Models/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/WidgetUtil.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black, // navigation bar color
    statusBarColor: Colors.white,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ItemController(),
      child: MaterialApp(
        title: 'Spice Money Test',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColorDark: Colors.white,
        ),
        home: ItemsPage(),
      ),
    );
  }
}
