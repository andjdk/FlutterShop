import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//获取首页主题内容
Future getHomePageContent() async{
  try{
    print("开始获取首页数据......");
    Response response;
    Dio dio = Dio();
    dio.options.contentType=ContentType.parse("application/json; charset=utf-8");
    response = await dio.post(servicePath['homePageContent']);
    print("获取首页数据：$response");
    if(response.statusCode == 200){
      return response;
    }else{
      return Exception("后端接口出现异常");
    }
  }catch (e){
    return "error：==========> $e";
  }
}