import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';

import '../widgets/ui_elements/title_default.dart';
import '../widgets/products/address_tag.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String description;
  final double price;
  final String imageUrl;

  ProductPage(this.title, this.description, this.price, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          Navigator.pop(context, false);
          return Future.value(false);
        },
        child: Scaffold(
            appBar: AppBar(
              title: Text(title),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(imageUrl),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.00),
                  child: TitleDefault(title),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AddressTag('Union Square, San Francisco'),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        '|',
                        style:
                            TextStyle(fontFamily: 'Oswald', color: Colors.grey),
                      ),
                    ),
                    Text(
                      '\$' + price.toString(),
                      style:
                          TextStyle(fontFamily: 'Oswald', color: Colors.grey),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.all(10.0),
                  alignment: Alignment.center,
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            )));
  }
}
