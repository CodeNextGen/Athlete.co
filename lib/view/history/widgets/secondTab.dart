import 'package:attt/utils/colors.dart';
import 'package:attt/utils/size_config.dart';
import 'package:flutter/material.dart';

Widget secondTab(BuildContext context) {
  SizeConfig().init(context);
  return Container(
    width: SizeConfig.blockSizeHorizontal * 50,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.show_chart,
          color: Colors.white,
          size: SizeConfig.blockSizeHorizontal * 6,
        ),
        Text(
          'History',
          style: TextStyle(
            color: MyColors().white,
            fontSize: SizeConfig.safeBlockHorizontal * 3.5
          ),
        ),
      ],
    ),
  );
}
