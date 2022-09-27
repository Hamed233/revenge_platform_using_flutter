import 'package:flutter/material.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/screens/profile/playlist_details_screen.dart';

class PlaylistComponent extends StatelessWidget {
  const PlaylistComponent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsetsDirectional.only(bottom: 10.0),
                  child: Container(
                    width: double.infinity,
                    height: 180.0,
                    padding: EdgeInsetsDirectional.only(bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://images.pexels.com/photos/776656/pexels-photo-776656.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.4), BlendMode.darken),
                      ),
                    ),
                    child: InkWell(
                      onTap: () {
                        navigateTo(context, PlaylistDetails());
                      },
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                                child: Icon(
                              Icons.play_arrow,
                              size: 50,
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Playlist Name",
                                  style: Theme.of(context).textTheme.headline2!.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "30 items",
                                  style: Theme.of(context).textTheme.headline3!.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                        
                          ],
                        ),
                      ),
                    ),
                  ),
                );
  }
}