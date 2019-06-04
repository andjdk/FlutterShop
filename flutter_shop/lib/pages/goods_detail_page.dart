import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/goods_detail.dart';
import 'package:flutter_shop/service_method/service_method.dart';
import 'package:provide/provide.dart';

class GoodsDetailPage extends StatefulWidget{

  final String goodsId;

  GoodsDetailPage(this.goodsId);

  @override
  State<StatefulWidget> createState() {
    return _GoodsDetailPageSate(goodsId);
  }

}

class _GoodsDetailPageSate extends State<GoodsDetailPage> {

  String goodsId;
  String goodsDetailJson = '{"code":"0","message":"success","data":{"goodInfo":{"image5":"","amount":10000,"image3":"","image4":"","goodsId":"ed675dda49e0445fa769f3d8020ab5e9","isOnline":"yes","image1":"http://images.baixingliangfan.cn/shopGoodsImg/20190116/20190116162618_2924.jpg","image2":"","goodsSerialNumber":"6928804011173","oriPrice":3.00,"presentPrice":2.70,"comPic":"http://images.baixingliangfan.cn/compressedPic/20190116162618_2924.jpg","state":1,"shopId":"402880e860166f3c0160167897d60002","goodsName":"可口可乐500ml/瓶","goodsDetail":"<img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081109_5060.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081109_1063.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_8029.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_1074.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_8439.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_6800.jpg\" width=\"100%\" height=\"auto\" alt=\"\" />"},"goodComments":[{"SCORE":5,"comments":"果断卸载，2.5个小时才送到","userName":"157******27","discussTime":1539491266336}],"advertesPicture":{"PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190113/20190113134955_5825.jpg","TO_PLACE":"1"}}}';


  _GoodsDetailPageSate(this.goodsId);

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Provide.value<GoodsDetailInfoProvide>(context).getGoodsDetailInfo(goodsId);
    return Scaffold(
      appBar: AppBar(
        title: Text('商品详情'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            _topImage(context),
          ],
        )
      ),
    );
  }

  Widget _topImage(BuildContext context) {
    return Provide<GoodsDetailInfoProvide>(
      builder: (context,child,val){
        return Container(
          width: ScreenUtil().setWidth(570),
          child: Image.network(val.goodsDetailInfo.data.goodInfo.image1),
        );
      },
    );
  }

}
