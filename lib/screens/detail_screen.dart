import 'package:demo/Models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/WidgetUtil.dart';

class DetailScreen extends StatelessWidget {
  final ItemModel data;

  const DetailScreen({Key key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: customAppBar(data.name, false,context),
        body: Container(
          color: Colors.grey[200],
          child: ListView(
            children: [
              imageWidget(data),
              _priceChild(),
              SizedBox(height: 15),
              _detailDescChild(),
              SizedBox(height: 15),
              _exchangeDetailChild(),
              SizedBox(height: 15),
              _sizeChild(),
              SizedBox(height: 15),
              _descriptionWidget(),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priceChild() {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              data.name,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              data.shortDesc,
              style: TextStyle(fontSize: 15, color: Colors.black45),
            ),
            SizedBox(
              height: 30.0,
            ),
            data.discountPercentage.isEmpty
                ? Text(data.OrigPrice, style: TextStyle(fontSize: 14))
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("₹${data.OrigPrice}",
                          style: TextStyle(
                              fontSize: 19, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center),
                      SizedBox(
                        width: 3,
                      ),
                      Text("₹${data.DiscountPrice}",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                          textAlign: TextAlign.center),
                      SizedBox(
                        width: 3,
                      ),
                      Text(
                        "(${data.discountPercentage} OFF)",
                        style: TextStyle(fontSize: 16, color: Colors.orange),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "inclusive of all taxes",
              style: TextStyle(
                  color: Colors.green[600], fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _detailDescChild() => Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          child: Text(
            data.longDesc.discountDetails,
            style: TextStyle(color: Colors.black54, fontSize: 16.0),
          ),
        ),
      );

  Widget _exchangeDetailChild() => Container(
        color: Colors.white,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 10.0),
            child: Row(
              children: [
                Icon(Icons.swap_vert_circle_outlined),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  data.longDesc.exchangeDtls,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            )),
      );

  Widget _sizeChild() => Container(
        color: Colors.white,
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "SELECT SIZE",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "SIZE CHART",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
                children: data.longDesc.sizeDetails
                    .map((e) => _sizeWidget((e as Map).keys.first.toString()))
                    .toList()),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlineButton(
                  onPressed: () {},
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.favorite_border),
                        Text(
                          "WISHLIST",
                          style:
                              TextStyle(fontSize: 19.0, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                RaisedButton(
                  onPressed: () {},
                  color: Colors.pinkAccent,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shopping_bag,
                          color: Colors.white,
                        ),
                        Text(
                          "ADD TO BAG",
                          style: TextStyle(fontSize: 19.0, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _sizeWidget(String text) => Padding(
        padding: EdgeInsets.only(right: 10.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1.2),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          child: Padding(
              padding: EdgeInsets.all(7.0),
              child: Text(text,
                  style:
                      TextStyle(fontWeight: FontWeight.w700, fontSize: 21.0))),
        ),
      );

  Widget _descriptionWidget() => Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.longDesc.details
                .map((e) => _detailChild(e as Map))
                .toList(),
          ),
        ),
      );

  Widget _detailChild(Map data) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data.keys.first.toString(),
            style: TextStyle(color: Colors.black87),
          ),
          SizedBox(
            height: 2.0,
          ),
          Text(data.values.first.toString(),
              style: TextStyle(color: Colors.grey)),
          SizedBox(
            height: 7.0,
          ),
        ],
      );
}
