import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/service_method/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<String> banners = [
    'http://picapi.zhituad.com/photo/05/48/63ABA.jpg',
    'http://picapi.zhituad.com/photo/05/48/63ABA.jpg',
    'http://static6.eloancn.com/images/pic_14.jpg?eloancnV=201405281828',
  ];


  List navigatorList=[
    0,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("百姓生活+"),
        ),
        body: FutureBuilder(
            future: getHomePageContent(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                try {
                  var data = json.decode(snapshot.data.toString());
                  List<Map> swiper = (data['data']['slides'] as List).cast();
//                  List<Map> navigatorList = (data['data']['category'] as List).cast();
                  return Column(
                    children: <Widget>[
                      SwiperDiy(swiperDateList: banners),
                      TopNavigator(navigatorList: navigatorList,)
                    ],
                  );
                } catch (e) {
                  return Column(
                    children: <Widget>[
                      SwiperDiy(swiperDateList: banners),
                      TopNavigator(navigatorList: navigatorList,)
                    ],
                  );
                }
              } else {
                return Column(
                  children: <Widget>[
                    SwiperDiy(swiperDateList: banners),
                    TopNavigator(navigatorList: navigatorList,)
                  ],
                );
              }
            }));
  }
}

class SwiperDiy extends StatelessWidget {
  final List swiperDateList;

  SwiperDiy({this.swiperDateList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(333),
      width: ScreenUtil().setWidth(750),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            swiperDateList[index],
            fit: BoxFit.fill,
          );
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;

  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {

      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//          Image.network(
//            item['image'],
//            width: ScreenUtil().setWidth(95),
//            fit: BoxFit.fill,
//          ),
//          Text(item['mallCategoryName']),
          Icon(Icons.favorite,),
          Text(item.toString())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(320),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(5),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}
