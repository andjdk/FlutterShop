import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';


//获取首页主题内容
Future request(url,{formData}) async{
  try{

    print("request......");
    Response response;
    Dio dio = Dio();
    dio.options.contentType=ContentType.parse("application/json; charset=utf-8");
    if(formData == null){
      response = await dio.post(servicePath[url]);
    }else{
      print("request data：$formData");
      response = await dio.post(servicePath[url],data: formData);
    }
    print("request result：$response");
    if(response.statusCode == 200){
      return response;
    }else{
      return Exception("后端接口出现异常");
    }
  }catch (e){
    return "error：==========> $e";
  }
}


//获取首页火爆专区的数据
Future getHomePageBelowContent() async{
  try{
    print("开始获取首页火爆专区的数据......");
    Response response;
    Dio dio = Dio();
    dio.options.contentType=ContentType.parse("application/json; charset=utf-8");
    response = await dio.post(servicePath['homePageHotGoodsContent']);
    print("获取首页火爆专区的数据：$response");
    if(response.statusCode == 200){
      return response;
    }else{
      return Exception("后端接口出现异常");
    }
  }catch (e){
    return "error：==========> $e";
  }
}