
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/star.dart';
import 'package:flutter/material.dart';

Widget starsRow() {
  return Container(
    width: SizeConfig.blockSizeHorizontal * 100,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
        starIcon(),
      ],
    ),
  );
}
