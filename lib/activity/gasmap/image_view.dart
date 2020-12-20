import 'package:carmoa/data/photo.dart';
import 'package:flutter/material.dart';

class ImageView extends StatelessWidget {
  final Photo photo;

  ImageView({Key key, @required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${photo.author}'),
        elevation: 3,
      ),
      backgroundColor: Color.fromRGBO(235, 235, 235, 1),
      body: Column(
        children: [
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child:
                    Image.network('https://picsum.photos/id/${photo.id}/300/300'),
              ),
            ],
          ),
          SizedBox(height: 10.0,),
          Text('${photo.id}')
        ],
      ),
    );
  }
}
