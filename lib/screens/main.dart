import 'package:demo/network/ApiCall.dart';
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
        home: MyHomePage(),
      ),
    );
  }
}

// This class contains the first page of the application.
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    // ApiCall to get data
    ApiCall()
        .getDataFromServer(Provider.of<ItemController>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemController>(builder: (context, controller, child) {
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0), child: customAppBar("US POLO TAILORED FIT LINEN",true)),
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "FIT LINEN SHIRTS",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        controller.dataList.length > 0
                            ? Text(
                                "+${controller.dataList.length - 4} items",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.pinkAccent),
                              )
                            : SizedBox(),
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 0.0),
                      child: controller.dataList.isEmpty
                          ? Center(
                              child: CircularProgressIndicator(
                              backgroundColor: Colors.black12,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.pinkAccent),
                            ))
                          : MainChild(items: controller.dataList)),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Image.asset(
                    "lib/assets/sort.png",
                    width: 24,
                    color: Colors.grey,
                  ),
                  Text("SORT"),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.filter_alt,
                    color: Colors.grey,
                  ),
                  Text("FILTER"),
                ],
              )
            ],
          ),
        )),
        resizeToAvoidBottomInset: false,
      );
    });
  }
}

// This Widget have all the list items

class MainChild extends StatelessWidget {
  final List<ItemModel> items;

  const MainChild({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = List();
    widgets.addAll(items.map((e) => SingleItem(data: e)).toList());
    double width = MediaQuery.of(context).size.width / 2;
    double height =
        (MediaQuery.of(context).size.height - kToolbarHeight - 24) / 2;
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 30.0,
      children: widgets,
      childAspectRatio: width / height,
    );
  }
}

// Creates the UI for single Item including its image and data

class SingleItem extends StatelessWidget {
  final ItemModel data;

  const SingleItem({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DetailScreen(data:data)));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Container(
              child: imageWidget(data)
            )),
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.name,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          data.shortDesc,
                          style: TextStyle(fontSize: 11, color: Colors.grey),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        data.discountPercentage.isEmpty
                            ? Text(data.OrigPrice,
                                style: TextStyle(fontSize: 14))
                            : Wrap(
                                crossAxisAlignment: WrapCrossAlignment.end,
                                children: [
                                  Text("₹${data.OrigPrice}",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text("₹${data.DiscountPrice}",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough),
                                      textAlign: TextAlign.center),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "${data.discountPercentage} OFF",
                                    style: TextStyle(
                                        fontSize: 13, color: Colors.orange),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
