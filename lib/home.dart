import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'info.dart';
import 'model.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loading = true;
  bool imgloading = true;
  bool fav = false;
  List<Model> blogs = <Model>[];
  get http => null;

  void fetchBlogs() async {
    final String url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
    final String adminSecret =
        '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
    try {
      Response response = await get(Uri.parse(url), headers: {
        'x-hasura-admin-secret': adminSecret,
      });
      Map data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Request successful, handle the response data here
        // print('Response data: ${response.body}');
        data["blogs"].forEach((element) {
          Model model = new Model(
            id: 'id',
            image_url: 'url',
            title: 'title',
          );
          model = Model.fromMap(element);
          blogs.add(model);
        });
        setState(() {
          loading = false;
          imgloading = false;
        });
      } else {
        // Request failed
        print('Request failed with status code: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      // Handle any errors that occurred during the request
      print('Error: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'Blog Explorer',
          style: TextStyle(color: Colors.white),
        ),
        shadowColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black45,
              Colors.black26,
              Colors.black12,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // width: MediaQuery.of(context).size.width,
                // height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff213A50), Color(0xff071938)])),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: loading
                          ? CircularProgressIndicator()
                          : ListView.builder(
                              itemCount: 50,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Info(
                                                blogs[index].title,
                                                blogs[index].image_url)));
                                  },
                                  child: Card(
                                    shadowColor: Colors.white54,
                                    margin: EdgeInsets.all(20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    elevation: 0.0,
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          child: imgloading
                                              ? CircularProgressIndicator()
                                              : Image.network(
                                                  blogs[index].image_url,
                                                  fit: BoxFit.cover,
                                                  width: double.infinity,
                                                  height: 200,
                                                ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: fav
                                                  ? Icon(Icons.star)
                                                  : Icon(Icons.star_border),
                                              onPressed: () {
                                                setState(() {
                                                  fav = !fav;
                                                });
                                              },
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  88,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5, horizontal: 10),
                                              child: Text(
                                                blogs[index].title,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black45,
        onPressed: () {},
        child: Icon(Icons.message_outlined),
        hoverColor: Colors.black87,
      ),
    );
  }
}
