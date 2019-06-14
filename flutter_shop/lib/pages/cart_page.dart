import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/cart_info.dart';
import 'package:flutter_shop/provide/cart_list.dart';
import 'package:provide/provide.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provide.value<CartProvide>(context).getCartInfo();

    return Scaffold(
        appBar: AppBar(
          title: Text('购物车'),
        ),
        body: FutureBuilder(
            future: _getCartInfo(context),
            builder: (context, snapshot) {
              List cartList = Provide.value<CartProvide>(context).cartList;
              print('>>>> ${cartList.length} >>> ${snapshot.hasData}');
              if (snapshot.hasData && cartList != null) {
                return Stack(
                  children: <Widget>[
                    Provide<CartProvide>(
                        builder: (context, child, childCategory) {
                      cartList = Provide.value<CartProvide>(context).cartList;
                      print('${cartList.length}');
                      if (cartList.length != 0) {
                        return ListView.builder(
                          itemCount: cartList.length,
                          itemBuilder: (context, index) {
                            return _goodsCartItem(context, cartList[index]);
                          },
                        );
                      } else {
                        return Center(
                          child: Text('购物车还空着，快去挑选商品吧'),
                        );
                      }
                    }),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Provide<CartProvide>(builder: (context, child, scope) {
                        bool isAllCheck = Provide.value<CartProvide>(context).isAllCheck;
                        double allPrice = Provide.value<CartProvide>(context).allPrice;
                        cartList = Provide.value<CartProvide>(context).cartList;
                        if(cartList.length != 0){
                          return _cartBottom(context,isAllCheck,allPrice);
                        }else{
                          return Text("");
                        }
                      }),
                    )
                  ],
                );
              } else {
                return Center(
                  child: Text('正在加载中...'),
                );
              }
            }));
  }

  Widget _cartBottom(context,isAllCheck,allPrice) {
    return Container(
      width: ScreenUtil().setWidth(750),
      margin: EdgeInsets.all(5),
      color: Colors.white,
      child:  Row(
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: isAllCheck,
                    activeColor: Colors.pink,
                    onChanged: (bool val) {
                      Provide.value<CartProvide>(context)
                          .changeAllCheckBtnState(val);
                    },
                  ),
                  Text('全选')
                ],
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(430),
              alignment: Alignment.centerRight,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('合计：'),
                      Text(
                        '￥ ${(allPrice).toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.pink),
                      )
                    ],
                  ),
                  Container(
                    width: ScreenUtil().setWidth(430),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '满10元免配送费，预购免配送费',
                      style: TextStyle(
                          color: Colors.black38,
                          fontSize: ScreenUtil().setSp(22)),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: ScreenUtil().setWidth(150),
              padding: EdgeInsets.only(left: 10),
              child: RaisedButton(
                onPressed: () {},
                child: Text('结算',style: TextStyle(color: Colors.white),),
                color: Colors.red,

              ),
            )

          ],
        )
    );
  }

  Widget _goodsCartItem(BuildContext context, CartInfoModel data) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context, data),
          _cartImage(data),
          _cartGoodsName(context, data),
          _cartPrice(context, data)
        ],
      ),
    );
  }

  //多选按钮
  Widget _cartCheckBt(context, item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          item.isCheck = val;
          Provide.value<CartProvide>(context).changeCheckState(item);
        },
      ),
    );
  }

  //商品图片
  Widget _cartImage(item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  //商品名称
  Widget _cartGoodsName(context, item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName),
          Container(
            width: ScreenUtil().setWidth(165),
            margin: EdgeInsets.only(top: 5.0),
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black12)),
            child: Row(
              children: <Widget>[
                _reduceBtn(context, item),
                _countArea(item),
                _addBtn(context, item),
              ],
            ),
          )
        ],
      ),
    );
  }

  // 减少按钮
  Widget _reduceBtn(context, item) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count > 1 ? Colors.white : Colors.black12,
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: item.count > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  //添加按钮
  Widget _addBtn(context, item) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea(item) {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }

  //商品价格
  Widget _cartPrice(context, item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provide.value<CartProvide>(context)
                    .deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<String> _getCartInfo(BuildContext context) async {
  await Provide.value<CartProvide>(context).getCartInfo();
  return 'end';
}
