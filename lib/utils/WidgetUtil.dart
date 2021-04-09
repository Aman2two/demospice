import 'package:demo/Models/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget customAppBar(String text, bool showSubHeading, BuildContext context) =>
    AppBar(
      toolbarHeight: 70.0,
      brightness: Brightness.light,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontSize: 16),
          ),
          showSubHeading
              ? Text(
                  "1 items",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                )
              : SizedBox()
        ],
      ),
      leading: GestureDetector(
        child: Icon(
          Icons.arrow_back,
          color: Colors.black54,
          size: 30.0,
        ),
        onTap: () {
          showSubHeading ? SystemNavigator.pop() : Navigator.pop(context);
        },
      ),
      actions: [
        Icon(
          Icons.search,
          color: Colors.black54,
          size: 30.0,
        ),
        SizedBox(width: 10),
        Icon(
          Icons.favorite_border,
          color: Colors.black54,
          size: 30.0,
        ),
        SizedBox(width: 10),
        Icon(
          Icons.shopping_bag_outlined,
          color: Colors.black54,
          size: 30.0,
        ),
        SizedBox(width: 10),
      ],
    );

Widget imageWidget(ItemModel itemModel) => Image.network(
      itemModel.imageURL,
      errorBuilder: (context, object, sta) {
        return Center(
            child: Icon(
          Icons.image,
          size: 60.0,
          color: Colors.grey,
        ));
      },
      fit: BoxFit.cover,
    );
