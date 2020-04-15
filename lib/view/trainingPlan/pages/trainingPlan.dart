import 'package:attt/utils/size_config.dart';
import 'package:attt/view/home/pages/signin.dart';
import 'package:attt/view/trainingPlan/widgets/showAlertDialog.dart';
import 'package:attt/view_model/signInViewModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TrainingPlan extends StatelessWidget {
  final String trainerName;
  final String trainingPlanName;
  final String trainingPlanDuration;
  final FirebaseUser currentUser;
  TrainingPlan(
      {this.trainerName,
      this.trainingPlanDuration,
      this.trainingPlanName,
      this.currentUser});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi ' + currentUser.displayName),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 80,
              width: 80,
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 28.0,
                backgroundImage: NetworkImage(currentUser.photoUrl),
              ),
            ),
            Container(
              child: Text('Your training plan is: $trainingPlanName'),
            ),
            Container(
              child: Text('Duration is: $trainingPlanDuration weeks'),
            ),
            Container(
              child: Text('The man who will train you is: $trainerName'),
            ),
            Container(
              child: RaisedButton(
                child: Text('Sign out'),
                onPressed: () {
                  showAlertDialog(context);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}


