import 'package:flutter/material.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/screens/followers_and_followning_screens/person_container.dart';

class FollowingScreen extends StatelessWidget {
  const FollowingScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
  
    TextEditingController searchController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Following'),
        titleSpacing: 0,
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                // showMoreDetailsVideosBottomSheet(context);
              },
              icon: Icon(Icons.sort)),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white, borderRadius: BorderRadius.circular(5)),
                width: double.infinity,
                margin: EdgeInsetsDirectional.only(start: 10, end: 10),
                height: 40,
                child: Center(
                  child: TextFormField(
                    controller: searchController,
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "search",
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.appMainColors,
                      ),
                      focusColor: AppColors.appMainColors,
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 14),
                    cursorColor: AppColors.appMainColors,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter text to search';
                      }
                      return null;
                    },
                    onChanged: (String text) {
                      // TaskCubit.get(context).search(text);
                    },
                  ),
                ),
              ),
              SizedBox(height: 10,),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        height: 0.5,
                        width: MediaQuery.of(context).size.width / 1.3,
                        child: Divider(),
                      ),
                    );
                  },
                  // itemCount: followings.length,
                  itemCount: 2,
                  itemBuilder: (BuildContext context, int index) {
                    return PersonContainer();
                  },
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}