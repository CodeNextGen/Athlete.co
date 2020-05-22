import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

abstract class TrainingPlanInterface {
  Future getWeeks(String trainerID);
  Future getWorkouts(String trainerID, String weekID);
  navigateToWorkout(DocumentSnapshot userDocument, DocumentSnapshot userTrainerDocument, String trainerID, String workoutName, String weekID,
      String workoutID, String warmupDesc, BuildContext context, String weekName, List<dynamic> listOfNotes, bool alreadyFinishedWorkout);
  whatsAppOpen(String phoneNumber, String message, String screen, BuildContext context);
  secondTabPressed(BuildContext context, DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument, String userUID);
  firstTabPressed(BuildContext context, DocumentSnapshot userTrainerDocument,
      DocumentSnapshot userDocument);
  showAlertDialog(BuildContext context);
}
