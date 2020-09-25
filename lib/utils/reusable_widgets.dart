import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:convert/convert.dart';
import 'package:magic_bullet/about_us.dart';
import 'dart:convert';

import 'package:magic_bullet/utils/color_value.dart';

int previousNewsCount = 20;

class ReusableWidgets {
  static getAppBar(BuildContext context) {
    return AppBar(
      leading: CircleAvatar(
          radius: 4.0,
          backgroundImage: AssetImage(
            "assets/images/logo.jpg",
            // fit: BoxFit.scaleDown,
          )),
      title: Text(
        "Magic Bullet",
        style: TextStyle(color: blackColor),
      ),
      backgroundColor: whiteColor,
      actions: [
        Padding(
          padding: EdgeInsets.all(3),
        ),
        Row(
          children: [
            GestureDetector(
              child: Text(
                "FUN MODE",
                style:
                    TextStyle(color: blackColor, fontWeight: FontWeight.bold),
              ),
              onTap: () => ReusableWidgets.showDialogBox(context, "Coming Soon",
                  "This feature will appear very soon", "info"),
            ),
            Padding(
              padding: EdgeInsets.all(3),
            ),
            GestureDetector(
              child: Text("ABOUT US",
                  style: TextStyle(
                      color: blackColor, fontWeight: FontWeight.bold)),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => new AboutUs())),
            ),
            Padding(
              padding: EdgeInsets.all(3),
            ),
          ],
        )
      ],
    );
  }

  static showDialogBox(
      BuildContext context, String title, String description, String type) {
    return AwesomeDialog(
        context: context,
        dialogType: type == "info"
            ? DialogType.INFO
            : type == "warning"
                ? DialogType.WARNING
                : type == "error"
                    ? DialogType.ERROR
                    : type == "success"
                        ? DialogType.SUCCES
                        : DialogType.NO_HEADER,
        headerAnimationLoop: true,
        animType: AnimType.TOPSLIDE,
        title: title,
        desc: description,
        btnCancelOnPress: () {},
        btnOkOnPress: () {})
      ..show();
  }

  static generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
