import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:revenge_platform/blocs/general_app_bloc/states.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/video_component.dart';
import 'package:revenge_platform/test_json_data.dart';

import '../../blocs/general_app_bloc/app_general_bloc.dart';

class TopScreen extends StatelessWidget {
  const TopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsetsDirectional.only(
              top: 10,
              bottom: 10,
            ),
            child: Column(
              children: List.generate(home_video.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20, right: 10, left: 10),
                  child: VideoComponent(),
                );
              }),
            ),
          ),
        );
      },
    );
  }
}