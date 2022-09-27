import 'dart:async';

import 'package:ant_icons/ant_icons.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:revenge_platform/blocs/general_app_bloc/states.dart';
import 'package:revenge_platform/components/card_ads_component.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:ionicons/ionicons.dart';
import 'package:revenge_platform/components/video_component.dart';
import 'package:revenge_platform/data/sqlite_management/local_database_management.dart';
import 'package:revenge_platform/screens/home/body_of_home.dart';
import '../../blocs/general_app_bloc/app_general_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return bodyOfHome(context);
      },
    );
  }
}
