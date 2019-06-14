import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/model/goods_detail_info.dart';
import 'package:flutter_shop/provide/cart_list.dart';
import 'package:flutter_shop/provide/current_index.dart';
import 'package:flutter_shop/provide/goods_detail.dart';
import 'package:flutter_shop/service_method/service_method.dart';
import 'package:flutter_shop/utils/date_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';

class GoodsDetailPage extends StatefulWidget {
  final String goodsId;

  GoodsDetailPage(this.goodsId);

  @override
  State<StatefulWidget> createState() {
    return _GoodsDetailPageSate(goodsId);
  }
}

class _GoodsDetailPageSate extends State<GoodsDetailPage> {
  String goodsId;
  String goodsDetailJson =
      '{"code":"0","message":"success","data":{"goodInfo":{"image5":"","amount":10000,"image3":"","image4":"","goodsId":"ed675dda49e0445fa769f3d8020ab5e9","isOnline":"yes","image1":"http://images.baixingliangfan.cn/shopGoodsImg/20190116/20190116162618_2924.jpg","image2":"","goodsSerialNumber":"6928804011173","oriPrice":3.00,"presentPrice":2.70,"comPic":"http://images.baixingliangfan.cn/compressedPic/20190116162618_2924.jpg","state":1,"shopId":"402880e860166f3c0160167897d60002","goodsName":"可口可乐500ml/瓶","goodsDetail":"<img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081109_5060.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081109_1063.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_8029.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_1074.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_8439.jpg\" width=\"100%\" height=\"auto\" alt=\"\" /><img src=\"http://images.baixingliangfan.cn/shopGoodsDetailImg/20171224/20171224081110_6800.jpg\" width=\"100%\" height=\"auto\" alt=\"\" />"},"goodComments":[{"SCORE":5,"comments":"果断卸载，2.5个小时才送到","userName":"157******27","discussTime":1539491266336}],"advertesPicture":{"PICTURE_ADDRESS":"http://images.baixingliangfan.cn/advertesPicture/20190113/20190113134955_5825.jpg","TO_PLACE":"1"}}}';

  _GoodsDetailPageSate(this.goodsId);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('商品详情'),
        ),
        body: FutureBuilder(
            future: _getBackInfo(context),
            builder: (context, snapshot) {
              print('snapshot : ${snapshot.hasData}');
              if (snapshot.hasData) {
                return Container(
                    child: Stack(
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(80)),
                      child: ListView(
                        children: <Widget>[
                          _detailsTopArea(),
                          _detailsExplain(),
                          _detailsTab(),
                          _detailsWeb(),
//                          _detailsBottom(),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Container(
                          height: ScreenUtil().setHeight(80),
                          child: _detailBottom()),
                    )
                  ],
                ));
              } else {
                return Text('加载中...');
              }
            }));
  }

  Future _getBackInfo(BuildContext context) async {
    await Provide.value<GoodsDetailInfoProvide>(context)
        .getGoodsDetailInfo(goodsId);
    return '完成加载';
  }

  Widget _detailsTopArea() {
    return Provide<GoodsDetailInfoProvide>(
      builder: (context, child, val) {
        var goodsInfo = Provide.value<GoodsDetailInfoProvide>(context)
            .goodsDetailInfo
            .data
            .goodInfo;
        if (goodsInfo != null) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(bottom: 10),
            child: Column(
              children: <Widget>[
                _goodsImage(goodsInfo.image1),
                _goodsName(goodsInfo.goodsName),
                _goodsNum(goodsInfo.goodsSerialNumber),
                _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice),
              ],
            ),
          );
        } else {
          return Text('正在加载中......');
        }
      },
    );
  }

  //商品图片
  Widget _goodsImage(String url) {
    return Image.network(url,
        fit: BoxFit.cover, width: ScreenUtil().setWidth(740));
  }

  //商品名称
  Widget _goodsName(name) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 10),
      child: Text(
        name,
        maxLines: 1,
        style: TextStyle(fontSize: ScreenUtil().setSp(30)),
      ),
    );
  }

  //商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号：$num',
        style: TextStyle(color: Colors.black26),
      ),
    );
  }

  //商品价格方法
  Widget _goodsPrice(presentPrice, oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥$oriPrice',
            style: TextStyle(
                color: Colors.deepOrangeAccent,
                fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '     市场价:     ',
            style: TextStyle(
              color: Colors.black,
              fontSize: ScreenUtil().setSp(24),
            ),
          ),
          Text(
            '￥$presentPrice',
            style: TextStyle(
              color: Colors.black26,
              fontSize: ScreenUtil().setSp(24),
              decoration: TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailsExplain() {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 10, top: 8, bottom: 8),
      child: Text(
        '说明：>急速送达>正品保证 ',
        style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: ScreenUtil().setSp(18),
            backgroundColor: Colors.white),
      ),
    );
  }

  Widget _detailsTab() {
    return Provide<GoodsDetailInfoProvide>(builder: (context, child, val) {
      var isLeft = Provide.value<GoodsDetailInfoProvide>(context).isLeft;
      var isRight = Provide.value<GoodsDetailInfoProvide>(context).isRight;
      return Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: 8),
        child: Row(
          children: <Widget>[_leftTab(isLeft), _rightTab(isRight)],
        ),
      );
    });
  }

  Widget _leftTab(bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailInfoProvide>(context)
            .changeLeftAndRight('left');
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isLeft ? Colors.pink : Colors.black12))),
        child: Text(
          '详情',
          style: TextStyle(color: isLeft ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  Widget _rightTab(bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<GoodsDetailInfoProvide>(context)
            .changeLeftAndRight('right');
      },
      child: Container(
        width: ScreenUtil().setWidth(375),
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isRight ? Colors.pink : Colors.black12))),
        child: Text(
          '评论',
          style: TextStyle(color: isRight ? Colors.pink : Colors.black),
        ),
      ),
    );
  }

  Widget _detailsWeb() {
    return Provide<GoodsDetailInfoProvide>(builder: (context, child, val) {
      String goodsDetail = Provide.value<GoodsDetailInfoProvide>(context)
          .goodsDetailInfo
          .data
          .goodInfo
          .goodsDetail;
      List goodsComment = Provide.value<GoodsDetailInfoProvide>(context)
          .goodsDetailInfo
          .data
          .goodComments;
      var isLeft = Provide.value<GoodsDetailInfoProvide>(context).isLeft;

      if (isLeft) {
        return Container(
          child: Html(data: goodsDetail),
        );
      } else {
        if (goodsComment.length > 0) {
          return Container(
            child: _commentList(goodsComment),
          );
        } else {
          return Container(
            child: Text('暂时还没有评论喔！'),
          );
        }
      }
    });
  }

  Widget _commentList(List goodsComment) {
    return ListView.builder(
        itemCount: goodsComment.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            color: Colors.white,
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(goodsComment[index].userName),
                Text(goodsComment[index].comments),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    DateUtil.getDateStrByMs(goodsComment[index].discussTime),
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(20),
                        color: Colors.black26),
                  ),
                )
              ],
            ),
          );
        });
  }

  Widget _detailBottom() {
    return Row(
      children: <Widget>[
        Stack(
          children: <Widget>[
            InkWell(
              onTap: (){
                Provide.value<CurrentIndexProvide>(context).changeIndex(2);
                Navigator.pop(context);
              },
              child: Container(
                width: ScreenUtil().setWidth(120),
                height: ScreenUtil().setHeight(80),
                alignment: Alignment.center,
                child: Icon(
                  Icons.shopping_cart,
                  size: 35,
                  color: Colors.red,
                ),
              ),
            ),
            Provide<CartProvide>(
              builder: (context, child, scope) {
                int count = Provide.value<CartProvide>(context).allGoodsCount;
                if(count>0){
                  return Positioned(
                      top: 0,
                      right: 10,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            border: Border.all(color:Colors.pink,width: 2),
                            borderRadius: BorderRadius.circular(12)
                        ),
                        child: Text(
                          '$count',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(22)),
                        ),
                      ));
                }else{
                  return Text('');
                }

              },
            )
          ],
        ),
        InkWell(
          onTap: () {
            GoodInfo goodsDetail =
                Provide.value<GoodsDetailInfoProvide>(context)
                    .goodsDetailInfo
                    .data
                    .goodInfo;
            Provide.value<CartProvide>(context).save(
                goodsDetail.goodsId,
                goodsDetail.goodsName,
                1,
                goodsDetail.oriPrice,
                goodsDetail.image1);
//            Fluttertoast.showToast(msg: '加入成功');
          },
          child: Container(
            width: ScreenUtil().setWidth(315),
            height: ScreenUtil().setHeight(80),
            alignment: Alignment.center,
            color: Colors.green,
            child: Text(
              '加入购物车',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(315),
          height: ScreenUtil().setHeight(80),
          alignment: Alignment.center,
          color: Colors.red,
          child: Text(
            '立即购买',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
