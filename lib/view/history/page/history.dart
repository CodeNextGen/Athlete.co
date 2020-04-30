import 'package:attt/utils/colors.dart';
import 'package:attt/utils/globals.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chooseAthlete/pages/chooseAthlete.dart';
import 'package:attt/view/history/widgets/historyCustomBottomNavigationBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  final DocumentSnapshot userDocument;
  final DocumentSnapshot userTrainerDocument;
  final String userUID;
  const History({Key key, this.userTrainerDocument, this.userDocument, this.userUID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: MyColors().lightBlack,
      body: Container(
        child: Center(
          child: RaisedButton(
            color: MyColors().black,
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (_) => ChooseAthlete(
                      userDocument: userDocument,
                      name: userDocument['display_name'],
                      email: userDocument['email'],
                      photo: userDocument['image'],
                      userUID: userUID,
                    ),
                  ),
                  (Route<dynamic> route) => false);
            },
            child: Text(
              'Change your athlete',
              style: TextStyle(
                color: MyColors().white,
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: historyCustomBottomNavigationBar(
          context, userDocument, userTrainerDocument),
    );
  }
}
