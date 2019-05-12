import 'package:flutter/material.dart';
import './pages/login.dart';
import './pages/home.dart';
import './pages/signup.dart';
void main(){
  runApp(
   MaterialApp(
     debugShowCheckedModeBanner: false,
     theme: ThemeData(
       primaryColor: Colors.green.shade900
     ),
     home: Login(
       
     ),
     initialRoute: '/',
     routes: <String, WidgetBuilder>{
       // Set routes for using the Navigator.
       '/home': (BuildContext context) => new HomePage(),
       '/login': (BuildContext context) => new Login(),
       '/signup': (BuildContext context) => new SignUp()
     },
   )
  );
}
