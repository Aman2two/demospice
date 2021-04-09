

import 'package:demo/Models/model.dart';
import 'package:flutter/cupertino.dart';

class ItemController  extends ChangeNotifier{
  List dataList=List();

  updateList(List<ItemModel> data){
    this.dataList=data;
    notifyListeners();
  }

}