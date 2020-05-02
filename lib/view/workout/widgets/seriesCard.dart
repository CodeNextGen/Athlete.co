import 'package:attt/models/exerciseModel.dart';
import 'package:attt/storage/storage.dart';
import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/exerciseCard.dart';
import 'package:attt/view_model/workoutViewModel.dart';
import 'package:flutter/material.dart';

Widget seriesCard(
  BuildContext context,
  String _seriesName,
  String trainerID,
  List<dynamic> _exercises,
  String _exerciseName,
  List<dynamic> _exerciseTips,
  String _exerciseVideo,
  String _exerciseImage,
  int _exerciseIsReps,
  int _exerciseReps,
  int _exerciseRest,
  int _exerciseSets,
  String weekID,
  String workoutID,
  String seriesID,
  String _exerciseID,
  Function refreshFromInfo,
) {
  SizeConfig().init(context);
  return Column(
    children: <Widget>[
      Container(
        color: MyColors().lightBlack,
        height: SizeConfig.safeBlockVertical * 2.5,
      ),
      Container(
        margin: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical * 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 2),
              child: Text(_seriesName,
                  style: TextStyle(
                      color: MyColors().white,
                      fontSize: SizeConfig.blockSizeHorizontal * 5)),
            ),
            FutureBuilder(
                future: WorkoutViewModel()
                    .getExercises(trainerID, weekID, workoutID, seriesID),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    _exercises = snapshot.data
                        .map((doc) => Exercise.fromDocument(doc))
                        .toList();

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: _exercises.length,
                        itemBuilder: (BuildContext context, int index) {
                          _exerciseName = _exercises[index].name;
                          _exerciseImage = _exercises[index].image;
                          _exerciseIsReps = _exercises[index].isReps;
                          _exerciseReps = _exercises[index].reps;
                          _exerciseRest = _exercises[index].rest;
                          _exerciseSets = _exercises[index].sets;
                          _exerciseTips = _exercises[index].tips;
                          _exerciseID = _exercises[index].exerciseID;
                          _exerciseVideo = _exercises[index].video;

                          // List<String> exVideo = [];
                          // exVideo.addAll(snapshot.data[index].data['video']);
                          // print('VIDEOS FROM FIREBASE: ' + exVideo.toString());

                          return ExerciseCard(
                            exerciseImage: _exerciseImage,
                            exerciseIsReps: _exerciseIsReps,
                            exerciseName: _exerciseName,
                            exerciseReps: _exerciseReps,
                            exerciseRest: _exerciseRest,
                            exerciseSets: _exerciseSets,
                            exerciseTips: _exerciseTips,
                            exerciseVideo: _exerciseVideo,
                            storage: Storage(),
                            exerciseID: _exerciseID,
                            refreshParent: refreshFromInfo,
                          );
                        });
                  } else {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                })
          ],
        ),
      ),
      Container(
        color: MyColors().lightBlack,
        height: SizeConfig.safeBlockVertical * 2.5,
      ),
    ],
  );
}
