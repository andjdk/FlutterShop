import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_info.dart';
class ChildCategory with ChangeNotifier{
  List<BxMallSubDto> childCategoryList = [];
  int childIndex;
  String categoryId='4';
  String subId='';
  int page=1;

  getChildCategory(List<BxMallSubDto> list,String categoryId){
    childIndex =0;
    page =1;
    this.categoryId = categoryId;
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId='';
    all.mallCategoryId= '00';
    all.comments='null';
    all.mallSubName = '全部';
    childCategoryList=[all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  changedChildIndex(int index,String id){
    childIndex = index;
    subId = id;
    notifyListeners();
  }

  addPage(){
    page++;
  }

}