import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:revenge_platform/blocs/profile_bloc/profile_bloc.dart';
import 'package:revenge_platform/blocs/profile_bloc/states.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/network/local/cache_helper.dart';

class SortByVideosSheet extends StatelessWidget {
  var currentSortType =
      CacheHelper.getData(key: CacheHelperKeys.profileVideosSortBy);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        ProfileBloc bloc = ProfileBloc.get(context);

        return Material(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 13.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.only(start: 10.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                bloc.sortBy(currentSortType);
                              },
                              child: Text(
                                "Cancel",
                                style: Theme.of(context).textTheme.headline4!.copyWith(
                                  fontSize: 15
                                ),  
                              )),
                        ),
                        Spacer(),
                        Text(
                          "Sort By",
                          style: Theme.of(context).textTheme.headline3
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(end: 10.0),
                          child: TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                
                                    // showMoreDetailsVideosBottomSheet(context);
                              },
                              child: Text(
                                "Done",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(fontSize: 15),
                              )),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 15,
                      end: 15,
                      top: 5,
                      bottom: 5,
                    ),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadiusDirectional.circular(10),
                        color: Colors.white,
                      ),
                    

                    child: Column(
                      children: [
                        _sortTypeBuilder(context, "Name"),
                        const Divider(),
                        _sortTypeBuilder(context, "New"),
                        const Divider(),
                        _sortTypeBuilder(context, "Oldest"),
                        const Divider(),
                        _sortTypeBuilder(context, "High View"),
                        const Divider(),
                        _sortTypeBuilder(context, "High Rank"),
                      ],
                    ),
                    )
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sortTypeBuilder(context, type) {
    return InkWell(
      onTap: () {
        ProfileBloc.get(context).sortBy(type);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              type,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Spacer(),
            if (ProfileBloc.get(context).sortType == type)
              Icon(
                Icons.check,
                color: AppColors.appMainColors,
              ),
          ],
        ),
      ),
    );
  }
}
