import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/category_goods_list.dart';
import 'package:flutter_shop/provide/child_category.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:flutter_shop/provide/goods_detail.dart';
import 'package:flutter_shop/routers/application.dart';
import 'package:flutter_shop/routers/routes.dart';
import 'package:provide/provide.dart';

import 'index_page.dart';
import 'package:fluro/fluro.dart';

void main(){
  var providers = Providers();


  providers
    ..provide(Provider<Counter>.value(Counter()))
    ..provide(Provider<ChildCategory>.value(ChildCategory()))
    ..provide(Provider<GoodsDetailInfoProvide>.value(GoodsDetailInfoProvide()))
    ..provide(Provider<CategoryGoodsListProvide>.value(CategoryGoodsListProvide()));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final router =  Router();
    Routes.configureRoutes(router);
    Application.router = router;
    return Container(
      child: MaterialApp(
        title: "百姓生活家",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.pink
        ),
        home: IndexPage(),
      ),
    );
  }
}