import 'dart:convert';

import 'package:api_learn/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PostModel> postList = [];   // when your api have not any array so make this.

  Future<List<PostModel>> getPostApi() async {
    postList.clear();
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (var item in data) {
        postList.add(PostModel.fromJson(item));
      }
      return postList;
    }
    return postList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Api',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Expanded(
        child: FutureBuilder(
          future: getPostApi(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: postList.length,
                itemBuilder: (context, index) {
                   return Card(
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Title',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),
                     Text(postList[index].title.toString(),),
                         Text('Description',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,),),

                         Text(postList[index].body.toString())
                       ],
                     ),
                   );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
