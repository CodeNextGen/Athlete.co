import 'package:attt/utils/size_config.dart';
import 'package:attt/view/trainingPlan/widgets/showAlertDialog.dart';
import 'package:flutter/material.dart';

class TrainingPlan extends StatelessWidget {
  final String trainerName;
  final String trainingPlanName;
  final String trainingPlanDuration;
  final String name, photo, email;
  TrainingPlan(
      {this.trainerName,
      this.trainingPlanDuration,
      this.trainingPlanName,
      this.photo,
      this.name,
      this.email});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hi ' + name),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: SizeConfig.blockSizeVertical * 12.5,
              width: SizeConfig.blockSizeHorizontal * 22,
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 28.0,
                backgroundImage: NetworkImage(photo),
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
