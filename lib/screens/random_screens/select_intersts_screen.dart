import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:revenge_platform/blocs/general_app_bloc/app_general_bloc.dart';
import 'package:revenge_platform/blocs/general_app_bloc/states.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/models/interests.dart';
import 'package:revenge_platform/screens/layout_of_app.dart';

class SelectInterestsScreen extends StatelessWidget {
  const SelectInterestsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {
        if (state is StoreInterestsToDBLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      builder: (context, state) {
        AppBloc cubit = AppBloc.get(context);

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              "What are your interests?",
              style: Theme.of(context).textTheme.headline2,
            ),
            centerTitle: false,
            actions: [
              if (state is! StoreInterestsToDBLoadingState)
                defaultTextButton(
                    color: cubit.selectedIntersts.isEmpty
                        ? Colors.grey
                        : AppColors.appMainColors,
                    function: () {
                      cubit.selectedIntersts.isEmpty
                          ? null
                          : cubit.storeInterestsToDB();
                      navigateAndFinish(context, AppLayout());
                    },
                    text: "Save"),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Container(child: _itemsBuilder(context, cubit)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _itemBuilder(context, InterestModel item, cubit) {
    return InkWell(
      onTap: () {
        item.isChosen = item.isChosen == false ? true : false;
        cubit.toggleSelectInterest(item);
      },
      child: Container(
        height: 10,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(50),
          border: Border.all(
            color: AppColors.appMainColors,
          ),
          color: item.isChosen! ? AppColors.appMainColors : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              item.icon!,
              style: TextStyle(fontSize: 27),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              item.title!,
              style: Theme.of(context).textTheme.headline2!.copyWith(
                    color: item.isChosen! ? Colors.white : Colors.black,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  GridView _itemsBuilder(context, cubit) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: interestsList.length,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 20,
        // width / height: fixed for *all* items
        childAspectRatio: 1,
      ),
      itemBuilder: (BuildContext context, int index) =>
          _itemBuilder(context, interestsList[index], cubit),
    );
    // return ListView.separated(
    //   shrinkWrap: true,
    //   scrollDirection: Axis.horizontal,
    //   itemBuilder: (context, index) {
    //     return _itemBuilder(context, interestsList[index], cubit);
    //   },
    //   separatorBuilder: (context, index) => Container(width: 10),
    //   itemCount: interestsList.length,
    // );
  }
}
