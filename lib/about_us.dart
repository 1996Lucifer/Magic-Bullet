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
                    style: TextStyle(
                        color: blackColor, fontWeight: FontWeight.bold),
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
        body: Stack(
          children: [
            Opacity(
              child: Image.asset("assets/images/logo.jpg", scale: 1),
              opacity: 0.2,
            ),
            SingleChildScrollView(
                child: Column(
              children: [
                Align(
                    alignment: Alignment.center,
                    child: Text("About Us",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))),
                Padding(
                    padding:
                        EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 7),
                    child: Text(
                        "Magic Bullet is all about escalating factual-based content on any issue that is in public Interest. It is a Startup of Media Students that will enhance your knowledge on various topics/Fields.We pledge to entertain and keep you updated with our each & every post. We at magic bullet assure quality over trend.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(fontSize: 20))),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Follow Us -",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold))),
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
                                        "https://m.facebook.com/Magicbullet20/posts/?ref=page_internal&mt_nav=0"),
                                    child: Text(
                                        "https://m.facebook.com/Magicbullet20/posts/?ref=page_internal&mt_nav=0",
                                        style: TextStyle(
                                            fontSize: 17,
                                            decoration:
                                                TextDecoration.underline)))))
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
                                        "https://instagram.com/magicbullet20?igshid=1xo3dr3e2ejd0"),
                                    child: Text(
                                        "https://instagram.com/magicbullet20?igshid=1xo3dr3e2ejd0",
                                        style: TextStyle(
                                            fontSize: 17,
                                            decoration:
                                                TextDecoration.underline)))))
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
                                    onTap: () {},
                                    //  launch(
                                    //     ""),
                                    child: Text("Coming Soon",
                                        style: TextStyle(
                                            fontSize: 17,
                                            decoration:
                                                TextDecoration.underline)))))
                      ],
                    )),
              ],
            )),
          ],
        ));
  }
}
