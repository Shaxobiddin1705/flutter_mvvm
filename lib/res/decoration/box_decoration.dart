import 'package:flutter/material.dart';
import 'package:flutter_mvvm/res/res.dart';

const BorderRadius defaultBorderRadius = BorderRadius.all(
  Radius.circular(DesignConstants.appCornerRadius),
);

const BoxDecoration boxDecorationRoundedWithShadowGrey = BoxDecoration(
  borderRadius: defaultBorderRadius,
  boxShadow: [
    BoxShadow(
      // color: AppColorLight.shadowColor,
      blurRadius: DesignConstants.shadowBlurRadius,
      offset: DesignConstants.shadowOffset,
    ),
  ],
);