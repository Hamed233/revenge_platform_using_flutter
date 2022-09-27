import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_locals.dart';
import 'package:libadwaita/libadwaita.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/extensions/brightness.dart';


extension ContextExtensions on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  ThemeData get theme => Theme.of(this);
  Brightness get brightness => Theme.of(this).brightness;
  bool get isDark => Theme.of(this).brightness.isDark;
  void back([VoidCallback? after]) {
    if (after != null) after();
    Navigator.of(this).pop();
  }
  
  Widget backLeading({VoidCallback? onBack, bool isCircular = false}) =>
      isCircular
          ? Container(
              decoration: ShapeDecoration(
                color: theme.canvasColor,
                shape: const StadiumBorder(),
              ),
              child: AdwHeaderButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: back,
              ),
            )
          : AdwHeaderButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: back,
            );

  Color get getBackgroundColor => brightness.getBackgroundColor;
  Color get getAltBackgroundColor => brightness.getAltBackgroundColor;
  Color get getAlt2BackgroundColor => brightness.getAlt2BackgroundColor;

  bool get isMobile =>
      (Platform.isAndroid && !isLandscape) || width < mobileWidth;

  MediaQueryData get queryData => MediaQuery.of(this);
  bool get isLandscape => queryData.orientation == Orientation.landscape;
  double get width => queryData.size.width;
  double get height => queryData.size.height;

  // AppLocalizations get locals => AppLocalizations.of(this)!;
}
