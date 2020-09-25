import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:magic_bullet/utils/color_value.dart';
import 'package:magic_bullet/utils/reusable_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CircleAvatar(
            radius: 4.0,
            backgroundImage: AssetImage(
              "assets/images/logo.jpg",
            )),
        title: Text(
          "Magic Bullet",
          style: TextStyle(color: blackColor),
        ),
        backgroundColor: whiteColor,
        actions: [
          Row(
            children: [
              GestureDetector(
                child: Text(
                  "FUN MODE",
                  style:
                      TextStyle(color: blackColor, fontWeight: FontWeight.bold),
                ),
                onTap: () => ReusableWidgets.showDialogBox(
                    context,
                    "Coming Soon",
                    "This feature will appear very soon",
                    "info"),
              ),
              Padding(
                padding: EdgeInsets.all(3),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Align(
              alignment: Alignment.center,
              child: Text("About Us",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
          Padding(padding: EdgeInsets.only(top: 5)),
          Text(""),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Follow Us -",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
          Padding(
            padding: EdgeInsets.only(top: 10),
          ),
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.facebook,
                    size: 45,
                    color: Colors.blue,
                  ),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () => launch(
                                  "https://www.instagram.com/p/B8BszxIhLrf/?igshid=v1fa8a6pyvam"),
                              child: Text("Fb",
                                  style: TextStyle(
                                      fontSize: 17,
                                      decoration: TextDecoration.underline)))))
                ],
              )),
          Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: [
                  FaIcon(
                    FontAwesomeIcons.instagram,
                    size: 45,
                    color: Colors.pink,
                  ),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: GestureDetector(
                              onTap: () => launch(
                                  "https://www.instagram.com/p/B8BszxIhLrf/?igshid=v1fa8a6pyvam"),
                              child: Text(
                                  "https://www.instagram.com/p/B8BszxIhLrf/?igshid=v1fa8a6pyvam",
                                  style: TextStyle(
                                      fontSize: 17,
                                      decoration: TextDecoration.underline)))))
                ],
              )),
          Padding(
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
                                  "https://www.instagram.com/p/B8BszxIhLrf/?igshid=v1fa8a6pyvam"),
                              child: Text("Youtube",
                                  style: TextStyle(
                                      fontSize: 17,
                                      decoration: TextDecoration.underline)))))
                ],
              )),
        ],
      )),
    );
  }
}
