import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/goods_detail_info.dart';
import 'package:flutter_shop/service_method/service_method.dart';

class GoodsDetailInfoProvide with ChangeNotifier{

  GoodsDetailInfo goodsDetailInfo=null;
  bool isLeft =true;
  bool isRight = false;

  getGoodsDetailInfo(String goodsId) async{
    var formData = {'goodsId':goodsId};
    await request('getGoodsDetailInfo',formData: formData).then((val){
      var responseData = json.decode(val.toString());
      goodsDetailInfo = GoodsDetailInfo.fromJson(responseData);
      notifyListeners();
    });
  }

  changeLeftAndRight(String val){
    if(val == 'left'){
      isLeft= true;
      isRight = false;
    }else{
      isLeft= false;
      isRight = true;
    }
    notifyListeners();
  }

}