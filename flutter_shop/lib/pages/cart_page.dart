import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/counter.dart';
import 'package:provide/provide.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentCounter = Provide.value<Counter>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Provide<Counter>(builder: (context, child, counter) {
              return Text('${counter.value}');
            }),
            RaisedButton(
              onPressed: () {
                Provide.value<Counter>(context).increment();
              },
              child: Text('递增'),
            )
          ],
        ),
      ),
    );
  }
}
