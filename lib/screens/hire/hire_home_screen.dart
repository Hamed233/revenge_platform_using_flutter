import 'package:flutter/material.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/search_field.dart';
import 'package:revenge_platform/screens/hire/category_hire_screen.dart';

class HireHomeScreen extends StatelessWidget {
  const HireHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Padding(
                  padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0, top: 10),
      child: ListView(
        // shrinkWrap: true,
        children: [
          SearchField(
            controller: searchController,
            hintText: "Search for category",
            borderColor: AppColors.appMainColors,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "I wanna hire a?",
            style: Theme.of(context).textTheme.headline2!.copyWith(
              color: Colors.black54
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 20,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 3.0, mainAxisSpacing: 3.0),
              itemBuilder: (BuildContext context, int index) {
                return _categoryBuilder(context);
              }),
        ],
      ),
    );
  }

  Widget _categoryBuilder(context) {
    return Container(
      width: double.infinity,
      height: 150.0,
      padding: EdgeInsetsDirectional.only(bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
          image: NetworkImage(
              "https://images.pexels.com/photos/776656/pexels-photo-776656.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      child: InkWell(
        onTap: () {
          navigateTo(context, CategoryHireScreen());
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Programmer",
                style: Theme.of(context).textTheme.headline2!.copyWith(
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                color: AppColors.appMainColors,
                padding: EdgeInsetsDirectional.only(start: 5, end: 5, top: 3, bottom: 3),
                child: Text(
                  "3000",
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
