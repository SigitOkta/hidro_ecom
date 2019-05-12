import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hidro_ecom/pages/login.dart';
import 'package:hidro_ecom/components/horisontal_listview.dart';
import 'package:hidro_ecom/components/products.dart';
import 'package:hidro_ecom/pages/cart.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c1.jpg'),
          AssetImage('images/c2.jpg'),
          AssetImage('images/c3.jpg'),
          AssetImage('images/c4.jpg'),
          AssetImage('images/c5.jpg'),
          AssetImage('images/c6.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 4.0,
        dotColor: Colors.green[300],
        dotBgColor: Colors.transparent,
      ),
    );
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.green[500],
        title: Text('FreshMart'),
        actions: <Widget>[
          new IconButton(icon: Icon(Icons.search),color: Colors.white, onPressed: (){}),
          new IconButton(icon: Icon(Icons.shopping_cart),color: Colors.white, onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
          })
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text('Sigit Okta'),
              accountEmail: Text('Oktasigit@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.green[300],
                  child: Icon(Icons.person,color: Colors.white,),
                ),
              ),
              decoration: new BoxDecoration(
                  color: Colors.green[500]
              ),
            ),
//Body
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket),
              ),
            ),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>new Cart()));
              },
              child: ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(Icons.shopping_cart,color: Colors.green,),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite),
              ),
            ),
            Divider(),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('Setting'),
                leading: Icon(Icons.settings, color: Colors.green[300]),
              ),
            ),
            InkWell(
              onTap: (){},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.green[300]),
              ),
            ),
            InkWell(
              onTap: (){
                _signOut();
              },
              child: ListTile(
                title: Text('Log Out'),
                leading: Icon(Icons.transit_enterexit, color: Colors.green[300]),
              ),
            ),

          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          image_carousel,
          new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text('Categories'),
          ),
          HorizontalList(),
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Text('Recent products'),
          ),
          //gridview
          Container(
            height: 320.0,
            child: Products(),
          )

        ],
      ),
    );
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut().then((value){
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()),
            (Route<dynamic> route) => false,);
    });
  }

}

