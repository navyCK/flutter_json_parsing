import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

import 'package:flutter_json_parsing/method.dart';
import 'package:flutter_json_parsing/photo.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'JSON PHOTO';

    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class PhotosList extends StatelessWidget {
  const PhotosList({Key? key, required this.photos}) : super(key: key);

  final List<Photo> photos;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        var photo = photos[index];
        return Container(
          child: Column(
            children: <Widget> [
              SizedBox(height: 20,),
              Text("album ID: ${photo.albumId}"),
              Text("ID: ${photo.id}"),
              Text("url: ${photo.url}"),
              Image.network(
                photos[index].thumbnailUrl,
              )
            ],
          ),
        );
      },
    );
  }
}