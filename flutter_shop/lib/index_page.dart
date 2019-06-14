import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/pages/cart_page.dart';
import 'package:flutter_shop/pages/category_page.dart';
import 'package:flutter_shop/pages/home_page.dart';
import 'package:flutter_shop/pages/member_page.dart';
import 'package:flutter_shop/provide/current_index.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:provide/provide.dart';
import 'package:flutter/services.dart';

class IndexPage extends StatelessWidget {

  JPush jPush = JPush();

  Future<void> initPlatFormatState(context) async {
    jPush.setup(
      appKey: "0e1add721eb22e3079087c97",
      channel: "theChannel",
      production: false,
      debug: true,
    );
    jPush.applyPushAuthority(
        new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    try {
      jPush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
            print('onReceiveNotification : $message');
          }, onOpenNotification: (Map<String, dynamic> message) async {
        print('onOpenNotification : $message');
        await Provide.value<CurrentIndexProvide>(context).changeIndex(2);
      }, onReceiveMessage: (Map<String, dynamic> message) async {
        print('onReceiveMessage : $message');
      });
    } on PlatformException {
      print('PlatformException : $PlatformException');
    }
  }

  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.home),
        title:Text('首页')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.search),
        title:Text('分类')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.shopping_cart),
        title:Text('购物车')
    ),
    BottomNavigationBarItem(
        icon:Icon(CupertinoIcons.profile_circled),
        title:Text('会员中心')
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    initPlatFormatState(context);
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    return Provide<CurrentIndexProvide>(

        builder: (context,child,val){
          int currentIndex= Provide.value<CurrentIndexProvide>(context).currentIndex;
          return Scaffold(
            backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
            bottomNavigationBar: BottomNavigationBar(
              type:BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              items:bottomTabs,
              onTap: (index){
                Provide.value<CurrentIndexProvide>(context).changeIndex(index);
              },
            ),
            body: IndexedStack(
                index: currentIndex,
                children: tabBodies
            ),
          );
        }
    );

  }
}
