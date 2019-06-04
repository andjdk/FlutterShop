import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_shop/routers/router_handler.dart';

class Routes{
  static String root = '/';
  static String detailsPage = '/detail';
  static void configureRoutes(Router router){
    router.notFoundHandler = new Handler(
      handlerFunc: (BuildContext context,Map<String,List<String>> parms){
        print('ERROR===>ROUTER WAS NOT FONUND');
      }
    );

    router.define(detailsPage, handler: detailsHandler);
  }
}