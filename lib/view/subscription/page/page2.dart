import 'package:attt/utils/colors.dart';
import 'package:attt/utils/emptyContainer.dart';
import 'package:attt/utils/size_config.dart';
import 'package:attt/view/subscription/page/widgets/resultCont.dart';
import 'package:attt/view/subscription/page/widgets/reviews.dart';
import 'package:attt/view/subscription/page/widgets/starRow.dart';
import 'package:attt/view/subscription/page/widgets/textCont.dart';
import 'package:attt/view/subscription/page/widgets/textReviews.dart';
import 'package:flutter/material.dart';

import 'widgets/centerText.dart';

Widget pageTwo(BuildContext context) {
  return Stack(
    children: <Widget>[
      Container(
        width: SizeConfig.blockSizeHorizontal * 100,
        height: SizeConfig.blockSizeVertical * 100,
        color: MyColors().lightBlack.withOpacity(0.5),
      ),
      Container(
        margin: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical * 33,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            reviews(ReviewText().name1, ReviewText().rev1, context),
            reviews(ReviewText().name3, ReviewText().rev3, context),
            MediaQuery.of(context).size.width < 400
                ? EmptyContainer()
                : reviews(ReviewText().name2, ReviewText().rev2, context),
          ],
        ),
      )
    ],
  );
}