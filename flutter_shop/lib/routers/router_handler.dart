import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/goods_detail_page.dart';

Handler detailsHandler = Handler(
  handlerFunc: (BuildContext context,Map<String,List<String>> parms){
    String goodsId= parms['id'].first;
    return  GoodsDetailPage(goodsId);
  }
);