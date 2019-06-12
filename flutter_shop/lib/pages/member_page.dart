import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:provide/provide.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('会员中心'),
        ),
        body: ListView(
          children: <Widget>[
            _topHeader(),
            _orderTitle(),
            _orderType(),
            _actionList(),
          ],
        ));
  }
}

Widget _topHeader() {
  return Container(
    width: ScreenUtil().setWidth(750),
    padding: EdgeInsets.all(20),
    color: Colors.pinkAccent,
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 30),
          child: ClipOval(
            child: Image.network(
              'https://avatars0.githubusercontent.com/u/7944222?s=460&v=4',
              width: ScreenUtil().setWidth(130),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            '蓝胖子',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(36), color: Colors.white),
          ),
        )
      ],
    ),
  );
}

Widget _orderTitle() {
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.white54, width: 1))),
    child: ListTile(
      leading: Icon(Icons.list),
      title: Text('我的订单'),
      trailing: Icon(Icons.keyboard_arrow_right),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
    ),
  );
}

Widget _orderType() {
  return Container(
    margin: EdgeInsets.only(top: 5),
    width: ScreenUtil().setWidth(750),
    height: ScreenUtil().setHeight(150),
    padding: EdgeInsets.only(top: 20),
    color: Colors.white,
    child: Row(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(187),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.party_mode,
                size: 30,
              ),
              Text('待付款'),
            ],
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(187),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.query_builder,
                size: 30,
              ),
              Text('待发货'),
            ],
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(187),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.directions_car,
                size: 30,
              ),
              Text('待收货'),
            ],
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(187),
          child: Column(
            children: <Widget>[
              Icon(
                Icons.content_paste,
                size: 30,
              ),
              Text('待评价'),
            ],
          ),
        )
      ],
    ),
  );
}

Widget _actionList(){
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Column(
      children: <Widget>[
        _myListTile('领取优惠券'),
        _myListTile('已领取优惠券'),
        _myListTile('地址管理'),
        _myListTile('客服电话'),
        _myListTile('关于我们'),
      ],
    ),
  );
}

Widget _myListTile(String title){

  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom:BorderSide(width: 1,color:Colors.black12)
        )
    ),
    child: ListTile(
      leading: Icon(Icons.blur_circular),
      title: Text(title),
      trailing: Icon(Icons.keyboard_arrow_right),
      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
    ),
  );
}