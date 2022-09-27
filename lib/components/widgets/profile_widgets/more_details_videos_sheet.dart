import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:revenge_platform/blocs/profile_bloc/profile_bloc.dart';
import 'package:revenge_platform/blocs/profile_bloc/states.dart';
import 'package:revenge_platform/components/random_components.dart';

class MoreDetailsVideosSheet extends StatelessWidget {

  MoreDetailsVideosSheet({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    ProfileBloc cubit = ProfileBloc.get(context);

    return BlocConsumer<ProfileBloc, ProfileStates>(
      listener: (context, state) {
      },
      builder: (context, state) {

        return Material(
          color: Colors.grey[200],
          child: SingleChildScrollView(
            child: Container(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.only(start: 7),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            }, 
                            child: Text(
                              "Cancel",
                              style: Theme.of(context).textTheme.headline4!.copyWith(
                                fontSize: 15
                              ),  
                              textAlign: TextAlign.start,
                            )
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.only(start: 110.0),
                            child: Text(
                              "Options",
                              style: Theme.of(context).textTheme.headline3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        // showSortByVideosBottomSheet(context);
                      },
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadiusDirectional.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.sort
                              ),
                              SizedBox(width: 7,),
                              Text(
                                "Sort By",
                                style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontSize: 16
                                ),  
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                color: Colors.black.withOpacity(.6),
                                size: 22,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

      },
    );
  }
}
