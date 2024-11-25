import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFour extends StatefulWidget {
  const ExampleFour({super.key});

  @override
  State<ExampleFour> createState() => _ExampleFourState();
}
// Without model

var data;

Future<void> getUserApi() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
  if (response.statusCode == 200) {
    data = jsonDecode(response.body.toString());
  }
}

class _ExampleFourState extends State<ExampleFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Without Model'),
        ),
        body: Expanded(
            child: FutureBuilder(
          future: getUserApi(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            ReusableRow(
                                title: 'Name',
                                value: data[index]['name'].toString()),
                            ReusableRow(title: 'Email', value: data[index]['email'].toString()),
                            ReusableRow(title: 'City', value: data[index]['address']['city'].toString()),
                            ReusableRow(title: 'Phone No', value: data[index]['phone'].toString()),
                            ReusableRow(title: 'Website', value: data[index]['website'].toString())
                          ],
                        ),
                      ),
                    ),
                  );
                },

              );
            }
          },
        )));
  }
}

class ReusableRow extends StatelessWidget {
  String title, value;

  ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(title), Text(value)],
    );
  }
}
