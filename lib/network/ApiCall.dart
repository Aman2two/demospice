

import 'dart:convert';

import 'package:demo/Models/model.dart';
import 'package:demo/Models/controller.dart';
import 'package:dio/dio.dart';



class ApiCall{

  Future<List<ItemModel>> getDataFromServer(ItemController controller) async{
      var dio= Dio();
      Response data=await dio.get("https://api.jsonbin.io/b/60141159ef99c57c734b89aa");
      List<dynamic>  list= jsonDecode(data.toString())['data'];
      List<ItemModel> items=list.map((e) => ItemModel.fromJson(e)).toList();
      controller.updateList(items);
      return items;
  }

}