import 'dart:async';

import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/asManyReps.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/clearButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/customTextAnimation.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/exerciseTypes/btnTimer.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/infoIcon.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nameWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/nextbutton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/noteButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/previousButton.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/setsWidget.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorWidgets/timerWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

Widget repsAndTimeType(
  BuildContext context,
  Function onWill,
  pauseAndPlayFunction,
  playNext,
  playPrevious,
  showFancyCustomDialog,
  playTimer,
  pauseTimer,
  resetTimer,
  int counter,
  index,
  isReps,
  listLenght,
  reps,
  sets,
  String name,
  video,
  repsDescription,
  exerciseTime,
  workoutID,
  weekID,
  currentSet,
  timerText,
  colorStatePaused,
  bool isTips,
  infoClicked,
  goBackToChewie,
  isFromPortrait,
  noteClicked,
  isOrientationFull,
  VideoController controller,
  List<dynamic> tips,
  DocumentSnapshot userDocument,
  userTrainerDocument,
  Timer timer,
) {
  return MediaQuery.of(context).orientation == Orientation.portrait ? Column(
    children: <Widget>[
      Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          Row(
            children: <Widget>[
              clearIcon(
                context,
                onWill,
              ),
            ],
          ),
          InkWell(
            onTap: () {
              if (counter == 0) {
                pauseAndPlayFunction();
                isTips = false;
                counter = 1;
              }
              Timer(Duration(seconds: 1), () {
                counter = 0;
              });
            },
            child: Container(
              width: SizeConfig.blockSizeHorizontal * 83,
              height: SizeConfig.blockSizeVertical * 20,
            ),
          )
        ],
      ),
      Column(children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 18),
          child: name.length > 17 ?
          MarqueeWidget(

            child: nameWidget(
              infoClicked,
              goBackToChewie,
              isFromPortrait,
              context,
              controller,
              name,
              video,
              colorStatePaused,
              tips,
              isReps,
              index,
              listLenght,
              pauseTimer,
            ),
          ) :  nameWidget(
            infoClicked,
            goBackToChewie,
            isFromPortrait,
            context,
            controller,
            name,
            video,
            colorStatePaused,
            tips,
            isReps,
            index,
            listLenght,
            pauseTimer,
          ),
        ),
        Container(
          padding: EdgeInsets.all(3),
          child: Text(
            reps,
            style: TextStyle(
              color: MyColors().lightWhite,
              fontSize: SizeConfig.safeBlockHorizontal * 4,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ]),
      Container(
        margin: EdgeInsets.only(
            top: repsDescription != null && repsDescription != ''
                ? SizeConfig.blockSizeVertical * 6
                : SizeConfig.blockSizeVertical * 4),
        child: Column(
          children: <Widget>[
            repsDescription != null && repsDescription != ''
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5.0),
                          topLeft: Radius.circular(5.0)),
                      color: Colors.grey,
                    ),
                    width: SizeConfig.blockSizeHorizontal * 95,
                    height: SizeConfig.blockSizeVertical * 5.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        asManyReps(
                          context,
                          repsDescription,
                        ),
                      ],
                    ),
                  )
                : EmptyContainer(),
            Container(
              width:  SizeConfig.blockSizeHorizontal * 95,
              height: repsDescription != null && repsDescription != ''
                  ? SizeConfig.blockSizeVertical * 17 : SizeConfig.blockSizeVertical * 20,
              decoration: BoxDecoration(
                borderRadius: repsDescription != null && repsDescription != ''
                    ? BorderRadius.only(
                        bottomLeft: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                      )
                    : BorderRadius.all(Radius.circular(5.0)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                      height: SizeConfig.blockSizeVertical * 10,
                      child: timerWidget(context, controller, timerText)),
                  BtnTimer(
                    colorStatePaused: colorStatePaused,
                    index: index,
                    listLenght: listLenght,
                    pauseTimer: pauseTimer,
                    playTimer: playTimer,
                    timer: timer,
                    playNext: playNext,
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: SizeConfig.blockSizeVertical * 5,
                    child: FlatButton(
                      onPressed: () => showFancyCustomDialog(context),
                      child: Text(
                        'EDIT TIMER',
                        style: TextStyle(
                            color: MyColors().lightBlack.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    setsWidget(
                      context,
                      currentSet,
                      sets,
                      isReps,
                    ),
                  ],
                )),
            SizedBox(
              height: SizeConfig.blockSizeVertical * 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                index == 0
                    ? SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 10,
                      )
                    : previousButton(
                        context,
                        playPrevious,
                        resetTimer,
                      ),
                Container(
                  child: Row(
                    children: <Widget>[
                      noteButton(
                        context,
                        noteClicked,
                        isFromPortrait,
                        isOrientationFull,
                        controller,
                        userDocument,
                        userTrainerDocument,
                        index,
                        listLenght,
                        isReps,
                        sets,
                        reps.toString(),
                        name,
                        workoutID,
                        weekID,
                        colorStatePaused,
                        pauseTimer,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 3,
                      ),
                      infoIcon(
                        infoClicked,
                        goBackToChewie,
                        isFromPortrait,
                        context,
                        controller,
                        name,
                        video,
                        colorStatePaused,
                        tips,
                        isReps,
                        index,
                        listLenght,
                        pauseTimer,
                      ),
                    ],
                  ),
                ),
                nextButton(
                        context,
                        playNext,
                        resetTimer,
                        controller,
                        index,
                        listLenght,
                      ),
              ],
            ),
          ],
        ),
      )
    ],
  ) : EmptyContainer();
}
