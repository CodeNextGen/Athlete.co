import 'package:attt/view/chewieVideo/widgets/globals.dart';
import 'package:attt/view/chewieVideo/widgets/rest.dart';
import 'package:attt/view/chewieVideo/widgets/stopwatch.dart';
import 'package:attt/view/workout/pages/workout.dart';
import 'package:attt/view_model/chewieVideoViewModel.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:attt/view/chewieVideo/widgets/indicatorsOnVideo.dart';

class ChewieListItem extends StatefulWidget {
  // This will contain the URL/asset path which we want to play
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final Function goToNextVideo, refresh;
  final int index;
  final String trainerID;
  final String workoutName, workoutID, weekID, warmupDesc;

  ChewieListItem({
    @required this.videoPlayerController,
    this.looping,
    this.refresh,
    this.goToNextVideo,
    this.index,
    this.workoutID,
    this.trainerID,
    this.workoutName,
    this.weekID,
    this.warmupDesc,
    Key key,
  }) : super(key: key);

  @override
  _ChewieListItemState createState() => _ChewieListItemState();
}

class _ChewieListItemState extends State<ChewieListItem> {
  @override
  void initState() {
    super.initState();

    // Wrapper on top of the videoPlayerController
    chewieController = ChewieController(
      allowedScreenSleep: false,
      fullScreenByDefault: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.landscapeRight],
      autoPlay: true,
      overlay: IndicatorsOnVideo(widget.videoPlayerController),
      showControls: false,
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: false,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );

    widget.videoPlayerController.addListener(() {
      if (widget.videoPlayerController.value.position ==
          widget.videoPlayerController.value.duration) {
        if (widget.index == 2) {
          chewieController.exitFullScreen();

          /// full training stopwatch
          var timerService = TimerService.of(context);
          timerService.stop();
          //timerService.dispose();

          /// treba proslijediti paramete u workout
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => Workout(
                  trainerID: widget.trainerID,
                  warmupDesc: widget.warmupDesc,
                  weekID: widget.weekID,
                  workoutID: widget.workoutID,
                  workoutName: widget.workoutName,
                ),
              ),
              (Route<dynamic> route) => false);
        } else {
          ChewieVideoViewModel().showOverlay(context);
          widget.goToNextVideo(widget.index);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    /// start full training stopwatch
    var timerService = TimerService.of(context);
    timerService.start();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: chewieController,
      ),
    );
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   // IMPORTANT to dispose of all the used resources
  //   widget.videoPlayerController.dispose();
  //   _chewieController.dispose();
  // }
}