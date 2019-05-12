import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidro_ecom/pages/signup.dart';
import 'home.dart';
import '../admin/admin.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool passwordVisible = true;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordextController = TextEditingController();
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    isSignedIn();
  }

  void _toggle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  void isSignedIn() async {
    setState(() {
      loading = true;
    });
    preferences = await SharedPreferences.getInstance();
    FirebaseUser user = await firebaseAuth.currentUser();
    if (user != null) {
      setState(() => isLogedin = true);
      if (user.uid == "2AyN5AZSYwauAr7RPaq3jCXfMBQ2") {
        setState(() => isAdmin = true);
      }
    }

    if (isLogedin) {
      if (isAdmin) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Admin()));
      }else{
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    }

    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      loading = true;
    });

    FirebaseUser firebaseUser = await firebaseAuth
        .signInWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordextController.text)
        .catchError((e) => {
              Fluttertoast.showToast(msg: "no account"),
              setState(() {
                loading = false;
              }),
            });
    if (FirebaseUser != null) {
      await preferences.setString("id", firebaseUser.uid);
      await preferences.setString("username", firebaseUser.displayName);
      await preferences.setString("email", firebaseUser.email);
      Fluttertoast.showToast(msg: "login was successful");
      isSignedIn();
    } else {
      await preferences.setString("id", firebaseUser.uid);
      await preferences.setString("username", firebaseUser.displayName);
      await preferences.setString("email", firebaseUser.email);
      Fluttertoast.showToast(msg: "no account");
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/back.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
              child: new Container(
                decoration:
                    new BoxDecoration(color: Colors.black.withOpacity(0.4)),
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'images/lg.png',
                  width: 280.0,
                  height: 240.0,
                ),
              ),
              Container(
                child: Center(
                  child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white.withOpacity(0.5),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  controller: _emailTextController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    icon: Icon(Icons.email),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      Pattern pattern =
                                          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                      RegExp regex = new RegExp(pattern);
                                      if (!regex.hasMatch(value))
                                        return 'Please make sure your email address is valid';
                                      else
                                        return null;
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white.withOpacity(0.5),
                              elevation: 0.0,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12.0),
                                child: TextFormField(
                                  obscureText: passwordVisible,
                                  controller: _passwordextController,
                                  decoration: new InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      icon: Icon(Icons.lock_outline),
                                      suffixIcon: IconButton(
                                          icon: Icon(
                                            passwordVisible
                                                ? Icons.visibility
                                                : Icons.visibility_off,
                                            color: Colors.black,
                                          ),
                                          onPressed: () {
                                            // Update the state i.e. toogle the state of passwordVisible variable
                                            _toggle();
                                          })),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "the password field connot be empty";
                                    } else if (value.length < 6) {
                                      return "the password has to be at least 6 characters long";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: Colors.green.withOpacity(0.7),
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: () {
                                    handleSignIn();
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Login",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Forgot password",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
//                          Expanded(child: Container()),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Material(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                color: Colors.green.withOpacity(0.7),
                                elevation: 0.0,
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed('/signup');
                                  },
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0)),
                                  minWidth: MediaQuery.of(context).size.width,
                                  child: Text(
                                    "Sign Up",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
