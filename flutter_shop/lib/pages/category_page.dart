import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category_goods.dart';
import 'package:flutter_shop/model/category_info.dart';
import 'package:flutter_shop/provide/child_category.dart';
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
        Provide.value<ChildCategory>(context).getChildCategory(childList);
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
          .getChildCategory(list[0].bxMallSubDto);
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
                return InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Text(
                      childCategoryList.childCategoryList[index].mallSubName,
                      style: TextStyle(fontSize: ScreenUtil().setSp(28)),
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
  List<CategoryListData> categoryGoodsList = [];

  @override
  void initState() {
    _getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child:Container(
          width: ScreenUtil().setWidth(570),
          child: _goodsItem(),
        ) ,
      );
  }

  Widget _goodsItem() {
    if (categoryGoodsList.length != 0) {
      List<Widget> goodsWidget = categoryGoodsList.map((val) {
        return InkWell(
            onTap: () {},
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
      return Text("没有相关商品");
    }
  }

  void _getGoodsList() async {
    var data = {"categoryId": '4', "categorySubId": "", "page": 1};
    await request('getGoodsList', formData: data).then((val) {
      var data = json.decode(val.toString());
      try {
        CategoryGoodsListModel goodsList =
            CategoryGoodsListModel.fromJson(data);

        setState(() {
          categoryGoodsList = goodsList.data;
        });
      } catch (e) {
        print("出现异常：$e");
      }
    });
  }
}
