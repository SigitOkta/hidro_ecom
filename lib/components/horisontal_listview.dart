import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
            image_location: 'images/cat/icon1.png',
            image_caption: 'Vegetables',
          ),
          Category(
            image_location: 'images/cat/icon2.png',
            image_caption: 'Seeds',
          ),
          Category(
            image_location: 'images/cat/icon3.png',
            image_caption: 'fertilizers',
          ),
          Category(
            image_location: 'images/cat/icon4.png',
            image_caption: 'Tools',
          ),
        ],
      ),
    );
  }
}

class Category extends StatelessWidget {
  final String image_location;
  final String image_caption;

  Category({this.image_location, this.image_caption});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 100.0,
          child: ListTile(
            title: Image.asset(
              image_location,
              width: 100.0,
              height: 80.0,
            ),
            subtitle: Container(
              alignment: Alignment.topCenter,
              child: Text(image_caption,style: new TextStyle(fontSize: 12.0),),
            ),
          ),
        ),
      ),
    );
  }
}
