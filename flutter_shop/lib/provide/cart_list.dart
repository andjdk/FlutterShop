import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:flutter_shop/utils/sp_util.dart';

class CartProvide with ChangeNotifier {
  String CART_KEY = 'cartInfos';

  String cartString="[]";
  List<CartInfoModel> cartList=[]; //商品列表对象
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //总的商品数量
  bool isAllCheck = true; //是否全选

  save(goodsId,goodsName,count,price,images) async{

    SpUtils.getString(CART_KEY).then((val){
      cartString = val;
    });
    var temp=cartString==null?[]:json.decode(cartString.toString());
    //把获得值转变成List
    List<Map> tempList= (temp as List).cast();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave= false;  //默认为没有
    int ival=0; //用于进行循环的索引使用
    allPrice=0;
    allGoodsCount=0;  //把商品总数量设置为0
    tempList.forEach((item){//进行循环，找出是否已经存在该商品
      //如果存在，数量进行+1操作
      if(item['goodsId']==goodsId){
        tempList[ival]['count']=item['count']+1;
        cartList[ival].count++;
        isHave=true;
      }
      if(item['isCheck']){
        allPrice+= (cartList[ival].price* cartList[ival].count);
        allGoodsCount+= cartList[ival].count;
      }
      ival++;
    });
    //  如果没有，进行增加
    if(!isHave){
      Map<String, dynamic> newGoods={
        'goodsId':goodsId,
        'goodsName':goodsName,
        'count':count,
        'price':price,
        'images':images,
        'isCheck': true  //是否已经选择
      };
      tempList.add(newGoods);
      cartList.add(new CartInfoModel.fromJson(newGoods));
      allPrice+= (count * price);
      allGoodsCount+=count;
    }
    //把字符串进行encode操作，
    cartString= json.encode(tempList).toString();

    SpUtils.setString(CART_KEY, cartString);//进行持久化
    await getCartInfo();
    print('添加到购物车完成');
  }

  //得到购物车中的商品
  getCartInfo() async{
    SpUtils.getString(CART_KEY).then((val) {
      cartString = val;
    });
    cartList = [];
    if (cartString != null) {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['price'] * item['count']);
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(new CartInfoModel.fromJson(item));
      });
    }
    notifyListeners();
    print('获取购物车完成');
  }

  //删除购物车中的商品
  remove() async{
    SpUtils.remove(CART_KEY);
    allPrice = 0;
    allGoodsCount = 0;
    cartList = [];
    notifyListeners();
    print('删除购物车中的商品完成');
  }

  //删除单个购物车商品
  deleteOneGoods(String goodsId) async{
    SpUtils.getString(CART_KEY).then((val){
      cartString = val;
    });
    List<Map> tempList= (json.decode(cartString.toString()) as List).cast();

    int tempIndex =0;
    int delIndex=0;
    tempList.forEach((item){

      if(item['goodsId']==goodsId){
        delIndex=tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString= json.encode(tempList).toString();
    SpUtils.setString(CART_KEY, cartString);
    await getCartInfo();
    print('删除单个购物车商品完成');
  }

//修改选中状态
  changeCheckState(CartInfoModel cartItem) async {
    SpUtils.getString(CART_KEY).then((val){
      cartString = val;
    });
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    SpUtils.setString(CART_KEY, cartString); //
    await getCartInfo();
    print('修改选中状态完成');
  }

  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async {
    SpUtils.getString(CART_KEY).then((val){
      cartString = val;
    });
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }

    cartString = json.encode(newList).toString();
    SpUtils.setString(CART_KEY, cartString); //
    await getCartInfo();
    print('点击全选按钮操作完成');
  }

  //增加减少数量的操作

  addOrReduceAction(var cartItem, String todo) async {
    SpUtils.getString(CART_KEY).then((val){
      cartString = val;
    });
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    SpUtils.setString(CART_KEY, cartString); //
    await getCartInfo();
    print('增加减少数量的操作完成');
  }
}
