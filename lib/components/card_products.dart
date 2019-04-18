import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Product_on_cart = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 1,
    },
    {
      "name": "Blazer2",
      "picture": "images/products/blazer2.jpeg",
      "price": 120,
      "size": "L",
      "color": "Blue",
      "quantity": 1,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: Product_on_cart.length,
      itemBuilder: (context, index) {
        return Single_cart_product(
          cart_prod_name: Product_on_cart[index]["name"],
          cart_prod_color: Product_on_cart[index]["color"],
          cart_prod_quantity: Product_on_cart[index]["quantity"],
          cart_prod_size: Product_on_cart[index]["size"],
          cart_prod_price: Product_on_cart[index]["price"],
          cart_prod_picture: Product_on_cart[index]["picture"],
        );
      },
    );
  }
}

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_price;
  final cart_prod_quantity;

  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_price,
    this.cart_prod_quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      child: Container(
        color: Colors.white,
        height: 130.0,
        child: ListTile(
            contentPadding: EdgeInsets.only(top: 1.0 ,bottom: 1.0 ),
            leading: Container( height: 100.0, width: 100.0, child: Image.asset(cart_prod_picture,fit: BoxFit.fill,), ),
            title: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: new Text(cart_prod_name),
            ),
            subtitle: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text("Size"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Text(
                        cart_prod_size,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
                      child: new Text("Color:"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: new Text(
                        cart_prod_color,
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                  ],
                ),
                new Container(
                  alignment: Alignment.topLeft,
                  child: new Text(
                    "\$${cart_prod_price}",
                    style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold,color: Colors.red),
                  ),
                )
              ],
            ),
          trailing: Padding(
            padding: const EdgeInsets.only(top:0.0),
            child: new Column(
              children: <Widget>[
                new IconButton(icon: Icon(Icons.arrow_drop_up), onPressed: (){}),
                new Text("$cart_prod_quantity"),
                new IconButton(icon: Icon(Icons.arrow_drop_down), onPressed: (){})
              ],
            ),
          ) ,
        ),
      ),
    );
  }
 /* void addQuantity(){
    cart_prod_quantity =cart_prod_quantity +1
  }*/

}
