import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_shop/service_method/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';

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
                try{
                  var data = json.decode(snapshot.data.toString());
                  List<Map> swiper = (data['data']['slides'] as List).cast();
                  return Column(
                    children: <Widget>[
                      SwiperDiy(swiperDateList:banners),
                    ],
                  );
                }catch (e){
                  return Column(
                    children: <Widget>[
                      SwiperDiy(swiperDateList:banners),
                    ],
                  );
                }
              }else{
                return Column(
                  children: <Widget>[
                    SwiperDiy(swiperDateList:banners),
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
      height: 150,
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(swiperDateList[index],fit: BoxFit.fill,);
        },
        itemCount: swiperDateList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}
