import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleTow extends StatefulWidget {
  const ExampleTow({super.key});

  @override
  State<ExampleTow> createState() => _ExampleTowState();
}

class _ExampleTowState extends State<ExampleTow> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotosApi() async {
    photosList.clear();
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));

    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
        print('Lise ${photosList.length}');
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Photos Api')),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getPhotosApi(),
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                return ListView.builder(

                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    return ListTile(


                      leading: CircleAvatar(backgroundImage: NetworkImage(
                          snapshot.data![index].url.toString()),),
                      title: Text('Noted id: ' +
                          snapshot.data![index].id.toString()),
                      subtitle: Text(snapshot.data![index].title.toString()),

                    );
                  },
                );
              }
              else{
                return CircularProgressIndicator();
              }
            },
          )),
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;

  Photos({required this.title, required this.url, required this.id});
}
