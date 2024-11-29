import 'dart:convert';
import 'package:api_learn/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ExampleFive extends StatefulWidget {
  const ExampleFive({super.key});

  @override
  State<ExampleFive> createState() => _ExampleFiveState();
}

class _ExampleFiveState extends State<ExampleFive> {
  final PageController controller = PageController();
  Future<ProductModel> getProductApi() async {
    try {
      final response =
          await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        return ProductModel.fromJson(data);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('An error occurred while fetching products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Complex Json'),
        ),
        body: Expanded(
          child: FutureBuilder<ProductModel>(
            future: getProductApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Center(child: Text('No data available'));
              }

              return ListView.builder(
                itemCount: snapshot.data!.products!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              child: Text(snapshot.data!.products![index].id
                                  .toString()),
                              height: MediaQuery.of(context).size.height *
                                  0.25, // 25% of screen height
                              width: MediaQuery.of(context).size.width *
                                  0.5, // 50% of screen width
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot
                                      .data!
                                      .products![index]
                                      .images![0]), // Use valid URL
                                  fit: BoxFit
                                      .cover, // Ensure the image covers the container
                                ),
                              ),
                            ),
                            Container(
                              child: Text(snapshot.data!.products![index].id
                                  .toString()),
                              height: MediaQuery.of(context).size.height *
                                  0.25, // 25% of screen height
                              width: MediaQuery.of(context).size.width *
                                  0.5, // 50% of screen width
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot
                                      .data!
                                      .products![index]
                                      .images![0]), // Use valid URL
                                  fit: BoxFit
                                      .cover, // Ensure the image covers the container
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  0.25, // 25% of screen height
                              width: MediaQuery.of(context).size.width *
                                  0.5, // 50% of screen width
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot
                                      .data!
                                      .products![index]
                                      .thumbnail!), // Use valid URL
                                  fit: BoxFit
                                      .cover, // Ensure the image covers the container
                                ),
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height *
                                  0.25, // 25% of screen height
                              width: MediaQuery.of(context).size.width *
                                  0.5, // 50% of screen width
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot
                                      .data!.products![index].meta!.qrCode
                                      .toString()), // Use valid URL
                                  fit: BoxFit
                                      .cover, // Ensure the image covers the container
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Text(snapshot.data!.products![index].price.toString()),
                    ],
                  );
                },
              );
            },
          ),
        ));
  }
}
