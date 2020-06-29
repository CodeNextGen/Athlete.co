import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/workout/widgets/info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';

Widget nameWidget(
    bool infoClicked,
    goBackToChewie,
    isFromPortrait,
    BuildContext context,
    VideoController controller,
    String name,
    String video,
    List<dynamic> exTips,
    int isReps,
    index,
    listLenght,
    Function pauseTimer,
    ) {
  SizeConfig().init(context);
  return GestureDetector(
    onTap: () {
      pauseTimer();
      if (infoClicked) {
        goBackToChewie = true;
        infoClicked = false;
        controller.pause();
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          isFromPortrait = true;
        else
          isFromPortrait = false;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => InfoExercise(
            vc: controller,
            exerciseNameForInfo: name,
            exerciseTips: exTips,
            exerciseVideoForInfo: video,
          ),
        ));
      } else {
        print('NE MOZE VIŠE PAŠA');
      }
    },
    child: Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 5),
      child: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.visible,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? SizeConfig.safeBlockHorizontal * 2
                    : SizeConfig.safeBlockHorizontal * 10),
      ),
    ),
  );
}
