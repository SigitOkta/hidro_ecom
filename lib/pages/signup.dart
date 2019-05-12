import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hidro_ecom/pages/login.dart';
import '../db/users.dart';
import 'home.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordextController = TextEditingController();
  TextEditingController _confirmPasswordTextController = TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  bool loading = false;
  bool isLogedin = false;
  bool passwordVisible = true;
  final _formKey = GlobalKey<FormState>();
  UserServices _userServices = UserServices();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void _toggle() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset('images/back.jpg',fit: BoxFit.cover ,width: double.infinity,height: double.infinity,),
          Container(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 3.0 ,sigmaY: 3.0),
              child: new Container(
                decoration: new BoxDecoration(
                    color: Colors.black.withOpacity(0.4)
                ),
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
                      child: Column(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white.withOpacity(0.5),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(

                                controller: _nameTextController ,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Full Name",
                                  icon: Icon(Icons.person_outline),
                                ),
                                validator: (value){
                                  if (value.isEmpty){
                                    return "the Name field connot be empty";
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[

                          ],
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
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailTextController ,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Email",
                                  icon: Icon(Icons.email),
                                ),
                                validator: (value){
                                  if (value.isEmpty){
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
                                controller: _passwordextController ,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    icon: Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          passwordVisible ? Icons.visibility : Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                        onPressed:() {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          _toggle();
                                        })
                                ),
                                validator: (value){
                                  if (value.isEmpty){
                                    return "the password field connot be empty";
                                  }else if(value.length<6){
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
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white.withOpacity(0.5),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: TextFormField(
                                obscureText: passwordVisible,
                                controller: _confirmPasswordTextController ,
                                decoration: new InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Confirm Password",
                                    icon: Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                        icon: Icon(
                                          passwordVisible ? Icons.visibility : Icons.visibility_off,
                                          color: Colors.black,
                                        ),
                                        onPressed:() {
                                          // Update the state i.e. toogle the state of passwordVisible variable
                                          _toggle();
                                        })
                                ),
                                validator: (value){
                                  if (value.isEmpty){
                                    return "the password field connot be empty";
                                  }else if(value.length<6){
                                    return "the password has to be at least 6 characters long";
                                  }else if(_passwordextController.text != value){
                                    return "the password do not match";
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
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0),),
                              color: Colors.green.withOpacity(0.7),
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () async {
                                  validateForm();
                              },
                                shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(20.0)),
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Sign Up",textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0,
                                  ),
                                ),
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                            },
                            child: Text(
                              "Already have an account? Sign in. ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0
                              ),
                            ),
                          ),
                        ),
                      ],)
                  ),
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

  Future validateForm() async {
    FormState formState = _formKey.currentState;

    if(formState.validate()){
      FirebaseUser user = await firebaseAuth.currentUser();
      //String userID = user.uid;
      if (user == null){
        Map<String, String> value =
        {
          "username":_nameTextController.text,
          "email": _emailTextController.text,
        };
        firebaseAuth
            .createUserWithEmailAndPassword(
              email: _emailTextController.text,
              password: _passwordextController.text)
            .then((user)=>{
              _userServices.createUser(
                  user.uid.toString(),
                  value
                  )
        }).catchError((e)=>{print(e.toString())});
        /*Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        }*/
       /* Navigator.of(context).pushReplacementNamed('/home');*/
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false,);
      }
    }

}
}
