import 'package:flutter/material.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/screens/random_screens/playlists_saved_screen.dart';
import 'package:revenge_platform/screens/random_screens/posts_saved_screen.dart';
import 'package:revenge_platform/screens/random_screens/profiles_saved_screen.dart';
import 'package:revenge_platform/screens/random_screens/videos_saved_screen.dart';

class SavedHomeScreen extends StatelessWidget {
  const SavedHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved"),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, SavedVideosScreen());
                    },
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(204, 255, 255, 255),
                      ),
                      child: Stack(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 3.0,
                                    mainAxisSpacing: 3.0),
                            itemBuilder: (BuildContext context, int index) =>
                                _itemBuilder(),
                          ),
                          _titleOfCategory(context, "videos", "200"),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, SavedPlaylistsScreen());
                    },
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(204, 255, 255, 255),
                      ),
                      child: Stack(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 3.0,
                                    mainAxisSpacing: 3.0),
                            itemBuilder: (BuildContext context, int index) =>
                                _itemBuilder(),
                          ),
                          _titleOfCategory(context, "Playlist", "200"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, SavedPostsScreen());
                    },
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(204, 255, 255, 255),
                      ),
                      child: Stack(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 3.0,
                                    mainAxisSpacing: 3.0),
                            itemBuilder: (BuildContext context, int index) =>
                                _itemBuilder(),
                          ),
                          _titleOfCategory(context, "posts", "200"),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      navigateTo(context, SavedProfilesScreen());
                    },
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromARGB(204, 255, 255, 255),
                      ),
                      child: Stack(
                        children: [
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 4,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 3.0,
                                    mainAxisSpacing: 3.0),
                            itemBuilder: (BuildContext context, int index) =>
                                _itemBuilder(),
                          ),
                          _titleOfCategory(context, "profiles", "200"),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemBuilder() {
    return Container(
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
    );
  }

  Widget _titleOfCategory(context, title, itemsCounter) {
    return Positioned.fill(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title.toUpperCase(),
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
            padding:
                EdgeInsetsDirectional.only(start: 5, end: 5, top: 3, bottom: 3),
            child: Text(
              itemsCounter + " item",
              style: Theme.of(context).textTheme.headline3!.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
