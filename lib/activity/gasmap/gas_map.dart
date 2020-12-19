import 'dart:convert';

import 'package:carmoa/data/photo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GasMap extends StatefulWidget {
  @override
  _GasMapState createState() => _GasMapState();
}

class _GasMapState extends State<GasMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        title: Text(
          'GasMap',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Photo>>(
                future: fetchPhoto(http.Client()),
                builder: (context, snap) {
                  return snap.hasData
                      ? PhotosList(photos: snap.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  PhotosList({Key key, this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Expanded(
                child: Image.network(
                    'https://picsum.photos/id/${photos[index].id}/200/200')),
            Text(
              photos[index].author,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 10,
            )
          ],
        );
      },
    );
  }
}

int page = 1;
int limit = 40;

Future<List<Photo>> fetchPhoto(http.Client client) async {
  final response =
      await client.get('https://picsum.photos/v2/list?page=$page&limit=$limit');
  return compute(
      parsePhotos, response.statusCode == 200 ? response.body : 'Error');
}

List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  if (responseBody == 'Error') {
    return parsed;
  } else {
    return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  }
}

// https://jsonplaceholder.typicode.com/photos
// https://picsum.photos/v2/list?page=2&limit=100
