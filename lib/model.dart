import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Photo {
  final int albumId;
  final int id;
  final String title;
  final String url;
  final String thumbnailUrl;

  Photo({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      albumId: json['albumId'],
      id: json['id'],
      title: json['title'],
      url: json['url'],
      thumbnailUrl: json['thumbnailUrl'],
    );
  }
}

class PhotoList extends StatefulWidget {
  @override
  _PhotoListState createState() => _PhotoListState();
}

class _PhotoListState extends State<PhotoList> {
  List<Photo> photos = [];

  Future<void> fetchPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Photo> fetchedPhotos =
          data.map((item) => Photo.fromJson(item)).toList();

      setState(() {
        photos = fetchedPhotos;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo List'),
      ),
      body: ListView.builder(
        itemCount: photos.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(photos[index].title),
            leading: Image.network(photos[index].thumbnailUrl),
            onTap: () {},
          );
        },
      ),
    );
  }
}
