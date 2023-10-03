import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class Info extends StatefulWidget {
  // const Info({Key? key}) : super(key: key);
  String title;
  String url;

  Info(this.title, this.url);
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool fav=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Marquee(
        //   text: widget.title,
        // ),
        title: Text(widget.title),
        actions: [
          InkWell(
              child: fav?Icon(Icons.star_border):Icon(Icons.star),
            onTap: (){
                setState(() {
                  fav=!fav;
                });
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black26,
              Colors.black12,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight
          ),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
          children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ClipRRect(
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.fitWidth,
                    width: double.infinity,
                    height: 300,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                child: Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  'Subspace is a global network platform that specializes in providing dedicated network solutions for real-time applications. It offers services that optimize network performance, routing traffic on the fastest paths at an IP level and at scale.The company is known for its focus on network optimization, apps, and network security solutions.Subspace has been involved in managing real-time traffic, particularly for WEBRTC applications.',
                  style: TextStyle(fontSize: 20),
                ),
              ),
          ],
        ),
            )),
      ),
    );
  }
}
