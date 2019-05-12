import 'package:cloud_firestore/cloud_firestore.dart';

class UserServices{
  createUser(String uid, Map value){
    Firestore.instance.collection('users').document(uid)
        .setData(value).catchError((e)=>{print(e.toString())});
    Firestore.instance.collection('users').document(uid)
        .updateData({'userId': uid}).catchError((e)=>{print(e.toString())});
  }
}