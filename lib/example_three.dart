import 'dart:convert';

import 'package:api_learn/model/users_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleThree extends StatefulWidget {
  const ExampleThree({super.key});

  @override
  State<ExampleThree> createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  List<UsersModel> usersApi = [];

  Future<List<UsersModel>> getUsersApi() async {
    final responce =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    var data = jsonDecode(responce.body.toString());

    if (responce.statusCode == 200) {
      for (var i in data) {
        print(i['id']);
        usersApi.add(UsersModel.fromJson(i));
      }
      return usersApi;
    } else {
      return usersApi;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users Model'),
        ),
        body: Expanded(
            child: FutureBuilder(
          future: getUsersApi(),
          builder: (context, snapshot) {

            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }

            return ListView.builder(
              itemCount: usersApi.length,
              itemBuilder: (context, index) {
                return
                  Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ReusableRow(
                            title: 'Name',
                            value: snapshot.data![index].name.toString()),
                        ReusableRow(title: 'Email', value: usersApi[index].email.toString()),
                        ReusableRow(title: 'City', value: snapshot.data![index].address!.city.toString()),
                        ReusableRow(title: 'Phone No', value: snapshot.data![index].phone.toString()),
                        ReusableRow(title: 'Website', value: snapshot.data![index].website.toString())
                      ],
                    ),
                  ),
                );
              },
            );
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
