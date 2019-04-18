import 'package:flutter/material.dart';
import 'package:hidro_ecom/main.dart';

import 'package:hidro_ecom/components/card_products.dart';
class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green[500],
        title: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage()));},
            child: Text('Cart')),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search), color: Colors.white, onPressed: () {}),
        ],
      ),

      body: new Cart_products(),

      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(child: ListTile(
              title: new Text("Total:"),
              subtitle: new Text("\Rp. 230"),
            )),
            Expanded(child: MaterialButton(
              onPressed: (){},
              child: new Text("Check Out",style: TextStyle(color: Colors.white),),
              color: Colors.red,),
            ),
            
          ],
        ),
      ),
    );
  }
}
