import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:magic_bullet/description_news.dart';
import 'package:magic_bullet/utils/color_value.dart';
import 'package:magic_bullet/utils/reusable_widgets.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var _listOfNews;
  var _listOfPreviousNews = [];
  var _listOfImageSlider = [];
  var editorBlock;
  ProgressDialog pr;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    _listOfPreviousNews = [];
    final now = DateTime.now();
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    pr.style(message: "Loading Data..");
    pr.show();

    Firestore.instance
        .collection("newsRecord")
        .document(formatDate(
            DateTime(now.year, now.month, now.day), [dd, '-', mm, '-', yyyy]))
        .collection("news")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      // pr.hide();
      setState(() {
        _listOfNews = snapshot.documents;
      });
    });

    Firestore.instance
        .collection("newsRecord")
        .document(formatDate(DateTime(now.year, now.month, now.day - 1),
            [dd, '-', mm, '-', yyyy]))
        .collection("news")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      pr.hide();
      snapshot.documents.forEach((element) {
        var _list = {};
        _list = element.data;
        setState(() {
          _listOfPreviousNews.add(_list);
        });
      });
    });

    Firestore.instance
        .collection("ImageSlider")
        .document('imageSlider')
        .get()
        .then((document) {
      pr.hide();
      setState(() {
        _listOfImageSlider = document.data["images"];
      });
    });
    Firestore.instance
        .collection("EditorBlockRecord")
        .getDocuments()
        .then((document) {
      pr.hide();
      setState(() {
        editorBlock = document.documents.last.data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(editorBlock);
    var preferredHeight = MediaQuery.of(context).size.height;
    var preferredWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: ReusableWidgets.getAppBar(context),
        body: editorBlock == null ||
                _listOfNews == null ||
                _listOfImageSlider == null ||
                _listOfPreviousNews == null
            ? Text("Fetching Data..",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400))
            : RefreshIndicator(
                color: Colors.red,
                onRefresh: () => _getData(),
                child: CustomScrollView(
                  slivers: <Widget>[
                    // _listOfNews.length == 0 || _listOfNews == null
                    //     ? SliverToBoxAdapter(child: Text(""))
                    //     :
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Padding(
                          padding: EdgeInsets.only(
                            left: preferredWidth * 0.01,
                            right: preferredWidth * 0.01,
                            top: preferredHeight * 0.01,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  // color: Colors.red,
                                  height: preferredHeight * 0.3,
                                  width: preferredWidth * 1.2,
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      autoPlay: true,
                                      autoPlayInterval: Duration(seconds: 2),
                                      autoPlayAnimationDuration:
                                          Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.easeIn,
                                      enlargeCenterPage: true,
                                    ),
                                    items: _listOfImageSlider.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                              // color: Colors.red,
                                              width: preferredWidth,
                                              // margin: EdgeInsets.symmetric(
                                              //     horizontal: 2),
                                              child: Image.memory(
                                                base64Decode(i.toString()),
                                              ));
                                        },
                                      );
                                    }).toList(),
                                  )),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: preferredHeight * 0.05),
                              ),
                              Divider(
                                color: redColor,
                                height: 5,
                                thickness: 5,
                                indent: 0,
                                endIndent: preferredWidth * 0.7,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: preferredHeight * 0.01),
                              ),
                              Text(
                                "From The Pen of The Editor",
                                style: TextStyle(fontSize: 30),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      top: 10, left: 3, right: 3, bottom: 5),
                                  child: Card(
                                      color: redCardColor,
                                      margin: EdgeInsets.only(
                                          top: preferredHeight * 0.02),
                                      elevation: 0,
                                      child: InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      new NewsDescription(
                                                          newsDescription:
                                                              editorBlock))),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    top:
                                                        preferredHeight * 0.01),
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(
                                                      left: preferredWidth *
                                                          0.02),
                                                  child: Text(
                                                    editorBlock["heading"],
                                                    style:
                                                        TextStyle(fontSize: 30),
                                                  )),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 5),
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding: EdgeInsets.all(5),
                                                  ),
                                                  // Padding(
                                                  //     padding: EdgeInsets.all(5)),
                                                  Expanded(
                                                      child: Text(
                                                    editorBlock["description"]
                                                                .length >
                                                            150
                                                        ? '${editorBlock["description"].substring(0, 150)}...'
                                                        : editorBlock[
                                                            "description"],
                                                    style: TextStyle(
                                                        color: blackColor),
                                                  )),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          left: preferredWidth *
                                                              0.02,
                                                          right:
                                                              preferredWidth *
                                                                  0.02,
                                                          bottom:
                                                              preferredWidth *
                                                                  0.02),
                                                      child: Image.memory(
                                                        base64Decode(
                                                            editorBlock[
                                                                "images"][0]),
                                                        height: 200,
                                                        width: 200,
                                                      )),
                                                ],
                                              ),
                                            ],
                                          )))),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: preferredHeight * 0.01),
                              ),
                              Divider(
                                color: redColor,
                                height: 5,
                                thickness: 5,
                                indent: preferredWidth * 0.7,
                                endIndent: 0,
                              ),
                              _listOfNews == null || _listOfNews.length == 0
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          top: 15, left: 10, bottom: 20),
                                      child: Text("",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)))
                                  : Padding(
                                      padding:
                                          EdgeInsets.only(top: 15, left: 10),
                                      child: Text("What's Burning",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                        childCount: 1,
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Padding(
                              padding: EdgeInsets.all(3),
                              child: _listOfNews.length == 0
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          top: 15, left: 10, bottom: 20),
                                      child: Text("",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)))
                                  : Card(
                                      color: (index % 2 == 0)
                                          ? redCardColor
                                          : greyColor,
                                      elevation: 10,
                                      child: InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          new NewsDescription(
                                                              newsDescription:
                                                                  _listOfNews[
                                                                      index]))),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                _listOfNews[index]
                                                            .data["images"]
                                                            .length ==
                                                        0
                                                    ? Image.asset(
                                                        "assets/images/no_image.png",
                                                        height: 250,
                                                        width: 300,
                                                      )
                                                    : Image.memory(
                                                        base64Decode(
                                                            _listOfNews[index]
                                                                    .data[
                                                                "images"][0]),
                                                        height: 200,
                                                        width: 300,
                                                      ),

                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 10, left: 10),
                                                    child: Text(
                                                        _listOfNews[index]
                                                            .data["heading"],
                                                        style: TextStyle(
                                                            fontSize: 24,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                // ),
                                                Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 3, left: 10),
                                                    child: Text(
                                                        _listOfNews[index]
                                                                    .data[
                                                                        "description"]
                                                                    .length >
                                                                150
                                                            ? '${_listOfNews[index].data["description"].substring(0, 150)}...'
                                                            : _listOfNews[index]
                                                                    .data[
                                                                "description"],
                                                        style: TextStyle(
                                                            fontSize: 18)))
                                              ]))));
                        },
                        childCount:
                            _listOfNews == null ? 0 : _listOfNews.length,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: _listOfPreviousNews.length == 0
                          ? Text("")
                          : Padding(
                              padding: EdgeInsets.only(
                                  top: 15, left: 10, bottom: 10),
                              child: Text("What You have Missed",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))),
                    ),
                    // _listOfPreviousNews.length == 0 ||
                    //         _listOfPreviousNews == null
                    //     ? SliverToBoxAdapter(child: Text(""))
                    //     :
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      (context, index) => Padding(
                          padding: EdgeInsets.only(
                            left: preferredWidth * 0.01,
                            right: preferredWidth * 0.01,
                            top: preferredHeight * 0.01,
                          ),
                          child:
                              // Column(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              new NewsDescription(
                                                  newsDescription:
                                                      _listOfPreviousNews[
                                                          index]))),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: 15, bottom: 10, top: 5),
                                      child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 20.0,
                                              width: 10.0,
                                              decoration: new BoxDecoration(
                                                color: Colors.black,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10)),
                                            Expanded(
                                                child: Text(
                                                    _listOfPreviousNews[index]
                                                                ["heading"]
                                                            .toString() +
                                                        " - " +
                                                        _listOfPreviousNews[
                                                                    index]
                                                                ["publishDate"]
                                                            .toString(),
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 20)))
                                          ])))
                          // ])
                          ),
                      childCount: _listOfPreviousNews == null
                          ? 0
                          : _listOfPreviousNews.length,
                    ))
                  ],
                )));
  }
}
