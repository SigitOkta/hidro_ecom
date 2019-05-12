import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../db/category.dart';
import '../db/product.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  CategoryService _categoryService = CategoryService();
  ProductService productService = ProductService();
  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey;
  Color green = Colors.green;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController quatityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController productNameController = TextEditingController();
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown = <
      DropdownMenuItem<String>>[];
  String _currentCategory;
  bool isLoading = false;
  File _image1;
  File _image2;
  File _image3;

  @override
  void initState() {
    _getCategories();
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = new List();
   for(int i = 0; i < categories.length;i ++){
     setState(() {
       items.insert(0, DropdownMenuItem(
           child: Text(categories[i].data['categoryName']),
         value: categories[i].data['categoryName'],
       ));
     });
   }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: white,
        leading: Icon(
          Icons.close,
          color: black,
        ),
        title: Text(
          "add product",
          style: TextStyle(color: black),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: isLoading ? CircularProgressIndicator():
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          borderSide:
                          BorderSide(color: grey.withOpacity(0.8), width: 1.0),
                          onPressed: () {
                            _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                                1);
                          },
                          child: _displayChild1()
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          borderSide:
                          BorderSide(color: grey.withOpacity(0.8), width: 1.0),
                          onPressed: () {
                            _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                                2);
                          },
                            child: _displayChild2()
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OutlineButton(
                          borderSide:
                          BorderSide(color: grey.withOpacity(0.8), width: 1.0),
                          onPressed: () {
                            _selectImage(
                                ImagePicker.pickImage(
                                    source: ImageSource.gallery),
                                3);
                          },
                            child: _displayChild3()
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'enter a product name with 15 characters maximum',
                    style: TextStyle(
                      color: green,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: productNameController,
                    decoration: InputDecoration(hintText: 'Product Name'),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the product name';
                      } else if (value.length > 15) {
                        return 'Product name cant have more then 15 letters';
                      }
                    },
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Category: ',
                        style: TextStyle(color: green),
                      ),
                    ),
                    DropdownButton(
                      items: categoriesDropDown,
                      onChanged: changeSelectedCategory,
                      value: _currentCategory,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: quatityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Quantity',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the product Quantity';
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Price',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'You must enter the product name';
                      }
                    },
                  ),
                ),
                FlatButton(
                  color: green,
                  textColor: white,
                  child: Text('add product'),
                  onPressed: () {
                    validateAndUpload();
                  },
                )
              ],
            ),
        ),
      ),
    );
  }

  _getCategories() async{
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropDown();
      _currentCategory = categories[0].data['categoryName'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() => _currentCategory = selectedCategory );
  }

  void validateAndUpload() async{
    if (_formKey.currentState.validate()){
      setState(() => isLoading = true);
      if(_image1 != null && _image2 != null && _image3 != null){
        String imageUrl1;
        String imageUrl2;
        String imageUrl3;

        final FirebaseStorage storage = FirebaseStorage.instance;
        final String picture1 = "1${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task1 = storage.ref().child(picture1).putFile(_image1);
        final String picture2 = "2${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task2 = storage.ref().child(picture2).putFile(_image2);
        final String picture3 = "3${DateTime.now().millisecondsSinceEpoch.toString()}.jpg";
        StorageUploadTask task3 = storage.ref().child(picture3).putFile(_image3);

        StorageTaskSnapshot snapshot1 = await task1.onComplete.then((snapshot)=>snapshot);
        StorageTaskSnapshot snapshot2 = await task2.onComplete.then((snapshot)=>snapshot);

        task3.onComplete.then((snapshot3)async{
          imageUrl1 = await snapshot1.ref.getDownloadURL();
          imageUrl2 = await snapshot2.ref.getDownloadURL();
          imageUrl3 = await snapshot3.ref.getDownloadURL();
          List<String> imageList = [imageUrl1,imageUrl2,imageUrl3];

          productService.uploadProduct(
            productName: productNameController.text,
            price: double.parse(priceController.text),
            images: imageList,
            category: _currentCategory,
            quantity: int.parse(quatityController.text));
          _formKey.currentState.reset();
          setState(() =>isLoading = false);
          Fluttertoast.showToast(msg: "Product Added");
          Navigator.pop(context);
        });
      } else{
        setState(() => isLoading = false);
        Fluttertoast.showToast(msg: 'all the images must be provided');
      }
    }
  }

  void _selectImage(Future<File> pickImage, int imageNumber) async {
    File tempImg = await pickImage;
    switch(imageNumber){
      case 1:
        setState(()=> _image1 = tempImg);
        break;
      case 2:
        setState(()=> _image2 = tempImg);
        break;
      case 3:
        setState(()=> _image3 = tempImg);
        break;
    }
  }

 Widget _displayChild1() {
   if (_image1 == null) {
     return Padding(
       padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
       child: new Icon(
         Icons.add,
         color: grey,
       ),
     );
   } else {
     return Image.file(
       _image1,
       fit: BoxFit.fill,
       width: double.infinity,
     );
   }
 }
  Widget _displayChild2() {
    if (_image2 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image2,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }
  Widget _displayChild3() {
    if (_image3 == null) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(14, 50, 14, 50),
        child: new Icon(
          Icons.add,
          color: grey,
        ),
      );
    } else {
      return Image.file(
        _image3,
        fit: BoxFit.fill,
        width: double.infinity,
      );
    }
  }
}
