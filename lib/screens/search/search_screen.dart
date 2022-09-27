import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:revenge_platform/blocs/general_app_bloc/app_general_bloc.dart';
import 'package:revenge_platform/blocs/general_app_bloc/states.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/search_field.dart';
import 'package:revenge_platform/routes/argument_bundle.dart';

class SearchScreen extends StatelessWidget {


  SearchScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
      return BlocConsumer<AppBloc, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var tasksCubit = AppBloc.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.appMainColors,
              elevation: 0,
              titleSpacing: 0,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.of(context).pop(context),
              ),
              title: Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
                width: double.infinity,
                height: 40,
                margin: const EdgeInsetsDirectional.only(end: 14.0),
                child: Center(
                  child: SearchField(
                    controller: searchController,
                    autofocus: true
                  ),
                ),
              ),

            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                // color: Theme.of(context).cardColor,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.av_timer_rounded,
                              color: Colors.grey.shade600,
                              size: 25
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                "Search keydssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
                                style: Theme.of(context).textTheme.bodyText1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline_sharp,
                                color: Colors.red,
                                size: 25
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(),
                     InkWell(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.av_timer_rounded,
                              color: Colors.grey.shade600,
                              size: 25
                            ),
                            const SizedBox(width: 10,),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Text(
                                "Search dsdsdsds",
                                style: Theme.of(context).textTheme.bodyText1,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 4,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.remove_circle_outline_sharp,
                                color: Colors.red,
                                size: 25
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    // if (state is SearchTaskLoadingState) Center(child: CircularProgressIndicator()),
                    SizedBox(height: 5.0,),
                    // if (state is RetrieveTaskDataFromDatabase)
                      // ConditionalBuilder(
                      //     condition: 1==Icons.crop_16_9_rounded,
                      //     // condition: tasksCubit.searchList.length > 0,
                      //     builder: (context) { 
                      //       return Column(
                      //       children: List.generate(
                      //         tasksCubit.searchList.length,
                      //             (index) {
                      //           return ListOfTasks(bundle: ArgumentBundle(extras: tasksCubit.searchList[index],),);
                      //         },
                      //       ),
                      //     );
                      //     },
                      //     fallback: (context) => SearchWidget(searchIn: "Tasks"))
                  ],
                ),
              ),
            ),
          );
        },
      );
        
      }
}
