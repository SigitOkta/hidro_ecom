import 'package:flutter/material.dart';
import 'package:hidro_ecom/main.dart';
import 'home.dart';

class ProductDetails extends StatefulWidget {
  final product_detail_name;
  final product_detail_picture;
  final product_detail_old_price;
  final product_detail_new_price;

  ProductDetails({
    this.product_detail_name,
    this.product_detail_picture,
    this.product_detail_old_price,
    this.product_detail_new_price,
  });

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green[500],
        title: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>new HomePage()));},
            child: Text('FreshMart')),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search), color: Colors.white, onPressed: () {}),
        ],
      ),
      body: ListView(
        children: <Widget>[
          new Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.product_detail_picture),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(widget.product_detail_name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                          child: new Text(
                            "\Rp. ${widget.product_detail_old_price}",
                            style: TextStyle(color: Colors.grey,
                                decoration: TextDecoration.lineThrough),
                          )
                      ),
                      Expanded(
                          child: new Text(
                            "\Rp. ${widget.product_detail_new_price}",
                            style: TextStyle(fontWeight: FontWeight.bold,
                                color: Colors.red),)
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Size"),
                            content: new Text(
                              "Choose the size"
                            ),
                            actions: <Widget>[
                              new MaterialButton(onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                                child: new Text('close'),
                              )
                            ],
                          );
                        }
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("size"),
                      ),
                      Expanded(
                          child: new Icon(Icons.arrow_drop_down)
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Colors"),
                            content: new Text(
                                "Choose the color"
                            ),
                            actions: <Widget>[
                              new MaterialButton(onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                                child: new Text('close'),
                              )
                            ],
                          );
                        }
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Color"),
                      ),
                      Expanded(
                          child: new Icon(Icons.arrow_drop_down)
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    showDialog(context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text("Quantity"),
                            content: new Text(
                                "Choose the Quantity"
                            ),
                            actions: <Widget>[
                              new MaterialButton(onPressed: (){
                                Navigator.of(context).pop(context);
                              },
                                child: new Text('close'),
                              )
                            ],
                          );
                        }
                    );
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 0.2,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: new Text("Qty"),
                      ),
                      Expanded(
                          child: new Icon(Icons.arrow_drop_down)
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {},
                  color: Colors.green,
                  textColor: Colors.white,
                  elevation: 0.2,
                  child: new Text('Buy Now'),
                ),
              ),
              new IconButton(
                  icon: Icon(Icons.add_shopping_cart, color: Colors.green,),
                  onPressed: () {}),
              new IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.green,),
                  onPressed: () {}),
            ],
          ),
          Divider(color: Colors.lightGreen,),
          new ListTile(
            title: new Text("Product Details"),
            subtitle: new Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
                "Adipiscing vitae proin sagittis nisl rhoncus mattis rhoncus urna neque. Congue nisi vitae suscipit tellus mauris a diam. "
            ),
          ),
          Divider(color: Colors.lightGreen,),
          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
              child: new Text("Product name",style: TextStyle(color:Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
              child: new Text(widget.product_detail_name),)
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Product brand",style: TextStyle(color:Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("Brand X"),)
            ],
          ),
          new Row(
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text("Product condition",style: TextStyle(color:Colors.grey),),),
              Padding(padding: EdgeInsets.all(5.0),
                child: new Text("New"),)
            ],
          ),
          Divider(color: Colors.lightGreen,),
          //similarproduct
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text("Similar products",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0 ),),
          ),
          Container(
            height: 360.0,
            child: SimilarProduct(),
          )
        ],
      ),
    );
  }
}

class SimilarProduct extends StatefulWidget {

  @override
  _SimilarProductState createState() => _SimilarProductState();
}

class _SimilarProductState extends State<SimilarProduct> {
  var product_list = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Blazer2",
      "picture": "images/products/blazer2.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Dress2",
      "picture": "images/products/dress2.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "hills",
      "picture": "images/products/hills1.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "hilss2",
      "picture": "images/products/hills2.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "pants",
      "picture": "images/products/pants2.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "skt",
      "picture": "images/products/skt1.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "skt2",
      "picture": "images/products/skt2.jpeg",
      "old_price": 120,
      "price": 85,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Similar_Single_prod(
            product_name: product_list[index]['name'],
            product_picture: product_list[index]['picture'],
            product_old_price: product_list[index]['old_price'],
            product_price: product_list[index]['price'],
          );
        });
  }
}
class Similar_Single_prod extends StatelessWidget {
  final product_name;
  final product_picture;
  final product_old_price;
  final product_price;

  Similar_Single_prod({
    this.product_name,
    this.product_picture,
    this.product_old_price,
    this.product_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: new Text("hero 1"),
          child: Material(
            child: InkWell(
              onTap: () => Navigator.of(context).push(new MaterialPageRoute(builder: (context)=> new ProductDetails(
                product_detail_name: product_name,
                product_detail_picture: product_picture,
                product_detail_old_price: product_old_price,
                product_detail_new_price: product_price,
              ))),
              child: GridTile(
                footer: Container(
                  color: Colors.white,
                  child: new Row(children: <Widget>[
                    Expanded(
                      child: Text(product_name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.0),),
                    ),
                    new Text("\Rp. ${product_old_price}",style: TextStyle(color: Colors.grey,
                        decoration: TextDecoration.lineThrough),),
                    new Text("  "),
                    new Text("\Rp. ${product_price}",style: TextStyle(color: Colors.red,),)
                  ],),
                ),
                child: Image.asset(
                  product_picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
      ),
    );
  }
}
