import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:localfarm/Datas/farm_data.dart';
import 'package:localfarm/Datas/product_data.dart';
import 'package:localfarm/widgets/category_list.dart';
import 'package:localfarm/widgets/farm_header.dart';
import 'package:localfarm/widgets/products_grid.dart';
import 'package:localfarm/widgets/products_tile.dart';
import 'package:transparent_image/transparent_image.dart';

class StoreScreen extends StatefulWidget {
  final FarmData farmData;
  StoreScreen(this.farmData);

  @override
  _StoreScreenState createState() => _StoreScreenState(farmData);
}

class _StoreScreenState extends State<StoreScreen> {
  final FarmData farmData;

  _StoreScreenState(this.farmData);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.3)]
              )
          ),
        ),
      actions: <Widget>[
        IconButton(
          onPressed: (){},
          icon: Icon(Icons.shopping_cart),
        )
      ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Theme.of(context).primaryColor, Theme.of(context).primaryColor.withOpacity(0.3)]
              )
            ),
          ),

          ListView(
            children: <Widget>[
              FarmHeader(farmData),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 15,top: 20),
                child: Text('Categorias', style: TextStyle(fontSize: 30),),
              ),
              CategoryList(),
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 15,top: 20),
                child: Text('Produtos', style: TextStyle(fontSize: 30),),
              ),
              FutureBuilder<QuerySnapshot>(
                future: Firestore.instance.collection('products').getDocuments(),
                builder: (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else{
                    return ProductsGrid(snapshot);
                  }
                },
              ),
            ],
          )
        ],
      )
    );
  }
}
