import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_goods.dart';

class CategoryGoodsListProvide extends ChangeNotifier{
  List<CategoryListData> goodsList = [];

  getCategoryListData(List<CategoryListData> list){
    goodsList = list;
    notifyListeners();
  }
}