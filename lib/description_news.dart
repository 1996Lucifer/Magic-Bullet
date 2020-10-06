import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:magic_bullet/utils/reusable_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDescription extends StatefulWidget {
  final newsDescription;

  NewsDescription({Key key, @required this.newsDescription});
  @override
  _NewsDescriptionState createState() => _NewsDescriptionState();
}

class _NewsDescriptionState extends State<NewsDescription> {
  List<String> _listImages = [];
  @override
  Widget build(BuildContext context) {
    var preferredHeight = MediaQuery.of(context).size.height;
    var preferredWidth = MediaQuery.of(context).size.width;
    // print("==--==" + widget.newsDescription["image"].length.toString());
    widget.newsDescription["images"].forEach((elem) {
      setState(() {
        _listImages.add(elem);
      });
    });

    return Scaffold(
      appBar: ReusableWidgets.getAppBar(context),
      body: OrientationBuilder(builder: (context, orientation) {
        return SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.only(top: 10, left: 3, right: 3, bottom: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                  child: Text(widget.newsDescription["heading"],
                      style: TextStyle(
                          fontSize: 25, fontWeight: FontWeight.bold))),
              SizedBox(
                  height: preferredHeight * 0.3,
                  width: preferredWidth,
                  child: _listImages.length == 0
                      ? Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/images/no_image.png"))
                      : _listImages.length == 1
                          ? Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.memory(
                                base64Decode(_listImages[0]),
                              ))
                          : CarouselSlider(
                              options: CarouselOptions(
                                autoPlay: true,
                                autoPlayInterval: Duration(seconds: 2),
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 800),
                                autoPlayCurve: Curves.easeIn,
                                enlargeCenterPage: true,
                              ),
                              items: _listImages.map((i) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    //print(i);
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // margin: EdgeInsets.symmetric(
                                        //     horizontal: 15.0),
                                        child: Image.memory(
                                          base64Decode(i),
                                        ));
                                  },
                                );
                              }).toList(),
                            )),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              // Align(
              //   alignment: Alignment.topCenter,
              //     child: , right: 5
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(widget.newsDescription["description"],
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                        height: 1.7,
                        // wordSpacing: 7,
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      )
                      // )
                      )),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              widget.newsDescription["facebook"] == ""
                  ? Text("")
                  : Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.facebook,
                            size: 45,
                            color: Colors.red,
                          ),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: GestureDetector(
                                      onTap: () => launch(
                                          widget.newsDescription["facebook"]),
                                      child: Text(
                                          widget.newsDescription["facebook"],
                                          style: TextStyle(
                                              fontSize: 17,
                                              decoration:
                                                  TextDecoration.underline)))))
                        ],
                      )),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              widget.newsDescription["instagram"] == ""
                  ? Text("")
                  : Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.instagram,
                            size: 45,
                            color: Colors.red,
                          ),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: GestureDetector(
                                      onTap: () => launch(
                                          widget.newsDescription["instagram"]),
                                      child: Text(
                                          widget.newsDescription["instagram"],
                                          style: TextStyle(
                                              fontSize: 17,
                                              decoration:
                                                  TextDecoration.underline)))))
                        ],
                      )),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              widget.newsDescription["youtube"] == ""
                  ? Text("")
                  : Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.youtube,
                            size: 45,
                            color: Colors.red,
                          ),
                          Expanded(
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: GestureDetector(
                                      onTap: () => launch(
                                          widget.newsDescription["youtube"]),
                                      child: Text(
                                          widget.newsDescription["youtube"],
                                          style: TextStyle(
                                              fontSize: 17,
                                              decoration:
                                                  TextDecoration.underline)))))
                        ],
                      )),
            ],
          ),
        ));
      }),
    );
  }
}
