import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_goods.dart';
import 'package:flutter_shop/model/category_info.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/service_method/service_method.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void _getGoodsList(BuildContext context) async {
  var data = {"categoryId": Provide.value<ChildCategory>(context).categoryId, "categorySubId": Provide.value<ChildCategory>(context).subId, "page": 1};
  await request('getGoodsList', formData: data).then((val) {
    var data = json.decode(val.toString());
    try {
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if(goodsList ==null){
        Provide.value<CategoryGoodsListProvide>(context).getCategoryListData([]);
      }else{
        Provide.value<CategoryGoodsListProvide>(context).getCategoryListData(goodsList.data);
      }

    } catch (e) {
      print("出现异常：$e");
    }
  });
}

class LeftCategoryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LeftCategoryNavState();
  }
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  int listIndex = 0;

  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getGoodsList(context);
    return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _leftInkWell(index);
            }));
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex);

    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childList = list[index].bxMallSubDto;
        Provide.value<ChildCategory>(context).getChildCategory(childList,list[index].mallCategoryId);
        _getGoodsList(context);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
            color: isClick ? Colors.black12 : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1, color: Colors.black12))),
        child: Text(list[index].mallCategoryName),
      ),
    );
  }

  void _getCategory() async {
    await request('getCategoryInfo').then((val) {
      var data = json.decode(val.toString());
      CategoryModel categoryModel = CategoryModel.fromJson(data);
      setState(() {
        list = categoryModel.data;
      });
      Provide.value<ChildCategory>(context)
          .getChildCategory(list[0].bxMallSubDto,list[0].mallCategoryId);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RightCategoryNavState();
  }
}

class _RightCategoryNavState extends State<RightCategoryNav> {
//  List list = ['全部','名酒','宝丰','北京二锅头','舍得','五粮液','茅台','散白','名酒'];
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategoryList) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(bottom: BorderSide(width: 1, color: Colors.black12))),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategoryList.childCategoryList.length,
              itemBuilder: (context, index) {
                isClick = (index == Provide.value<ChildCategory>(context).childIndex);
                return InkWell(
                  onTap: () {
                    Provide.value<ChildCategory>(context).changedChildIndex(index,childCategoryList.childCategoryList[index].mallSubId);

                    _getGoodsList(context);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Text(
                      childCategoryList.childCategoryList[index].mallSubName,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: isClick ? Colors.pink:Colors.black
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}



class CategoryGoodsList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryGoodsListState();
  }
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {

  var scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context,child,data){
        try{
          if(Provide.value<ChildCategory>(context).page==1){
            scrollController.jumpTo(0.0);
          }
        }catch (e){
          print('进入页面第一次初始化：$e');
        }
        if(data.goodsList.length>0){
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: SingleChildScrollView(
                controller: scrollController,
                scrollDirection: Axis.vertical,
                child: _goodsItem(data.goodsList),
              ),
            ),
          );
        }else{
          return Text("暂时没有相关商品");
        }
      },
    );
  }

  Widget _goodsItem(List categoryGoodsList) {
    if (categoryGoodsList.length != 0) {
      List<Widget> goodsWidget = categoryGoodsList.map((val) {
        return InkWell(
            onTap: () {
              Application.router.navigateTo(context, 'detail?id=${val.goodsId}');
            },
            child: Container(
              padding: EdgeInsets.all(5),
              width: ScreenUtil().setWidth(280),
              child: Column(
                children: <Widget>[
                  Image.network(val.image,
                      width: ScreenUtil().setWidth(280),
                      height: ScreenUtil().setHeight(280)),
                  Text(
                    '${val.goodsName}',
                    style: TextStyle(
                      color: Colors.pink,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Row(
                    children: <Widget>[
                      Text(' ￥${val.oriPrice}   '),
                      Text(
                        ' ￥${val.presentPrice}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            ));
      }).toList();

      return Wrap(
        spacing: 2,
        children: goodsWidget,
      );
    } else {
      return Text("暂时没有相关商品");
    }
  }
}
