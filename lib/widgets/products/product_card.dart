import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './price_tag.dart';
import '../ui_elements/title_default.dart';
import '../products/address_tag.dart';
import '../../models/product.dart';
import '../../scoped-models/products.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final int productIndex;

  ProductCard(this.product, this.productIndex);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Image.asset(product.image),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.00),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TitleDefault(product.title),
                SizedBox(width: 8.0),
                PriceTag(product.price.toString()),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: AddressTag('Union Square, San Francisco'),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.info),
                color: Theme.of(context).accentColor,
                onPressed: () => Navigator.pushNamed<bool>(
                    context, '/product/' + productIndex.toString()),
              ),
              ScopedModelDescendant<ProductsModel>(
                builder:
                    (BuildContext context, Widget child, ProductsModel model) {
                  return IconButton(
                    icon: Icon(
                      model.products[productIndex].isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,
                    ),
                    color: Colors.red,
                    onPressed: () {
                      model.selectProduct(productIndex);
                      model.toggleProductFavoriteStatus();
                    },
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
