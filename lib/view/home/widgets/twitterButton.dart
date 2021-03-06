import 'dart:async';
import 'dart:io';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/utils/text.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appavailability/flutter_appavailability.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<Map<String, String>> installedApps;

Future<void> getApps() async {
  List<Map<String, String>> _installedApps;

  if (Platform.isAndroid) {
    _installedApps = await AppAvailability.getInstalledApps();

    try {
      print(await AppAvailability.checkAvailability("com.twitter.android"));
      // Returns: Map<String, String>{app_name: Chrome, package_name: com.android.chrome, versionCode: null, version_name: 55.0.2883.91}

      print(await AppAvailability.isAppEnabled("com.twitter.android"));
      // Returns: true
      isInstalled = true;
    } catch (e) {
      isInstalled = false;
    }
  }

  installedApps = _installedApps;
}

Widget twitterButton(BuildContext context) {
  SizeConfig().init(context);
  return GestureDetector(
    onTap: () async {
      getApps();
      Timer(Duration(seconds: 1), () {
        if (isInstalled) {
          SignInViewModel().signInWithTwitter(context);
        } else
          showAlertDialog(context);
      });
    },
    child: Container(
        height: SizeConfig.blockSizeVertical * 6.25,
        width: SizeConfig.blockSizeHorizontal * 72,
        color: MyColors().twitterColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MyColors().white,
              ),
              height: SizeConfig.blockSizeVertical * 3.75,
              width: SizeConfig.blockSizeHorizontal * 6.667,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Icon(
                  FontAwesomeIcons.twitter,
                  color: MyColors().twitterColor,
                  size: SizeConfig.blockSizeVertical * 2.3,
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.blockSizeHorizontal * 3,
            ),
            Text(
              MyText().tButton,
              style: TextStyle(
                  color: MyColors().white,
                  fontSize: SizeConfig.safeBlockHorizontal * 4,
                  fontFamily: 'Roboto'),
            ),
          ],
        )),
  );
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text(
      "OK",
      style: TextStyle(color: MyColors().lightWhite),
    ),
    onPressed: () => Navigator.of(context).pop(),
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Not installed",
      style: TextStyle(color: MyColors().lightWhite),
    ),
    content: Text(
      "Please install Twitter app on your device.",
      style: TextStyle(color: MyColors().lightWhite),
    ),
    backgroundColor: Colors.lightBlue,
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
