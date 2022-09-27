// ignore_for_file: iterable_contains_unrelated_type

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:revenge_platform/blocs/video_bloc/states.dart';
import 'package:revenge_platform/blocs/video_bloc/video_bloc.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/default_form_field.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/models/playlist.dart';

class BottomPlaylistSheet extends StatelessWidget {
  bool isUpdate;
  String playlistTitle;
  Playlist? playlistModel;

  BottomPlaylistSheet(this.isUpdate, this.playlistTitle);

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    VideoBloc cubit = VideoBloc.get(context);
    List playlists = [];

    List currentPlaylistsNames = [];
    cubit.playlists.forEach((element) {
      currentPlaylistsNames.add(element.title);
    });

    return BlocConsumer<VideoBloc, VideoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (isUpdate) {
          playlists = cubit.playlists.toList();
          if (playlists.isNotEmpty) {
            titleController = TextEditingController()
              ..text = playlists[0]["title"].toString();
            descriptionController = TextEditingController()
              ..text = playlists[0]["description"].toString();
          }
        }

        return Material(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isUpdate)
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.red,
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    // DatabaseHelper.instance.deleteFromTable("Playlists", PlaylistId).then((value) {
                                    //   cubit.getPlaylistsList();
                                    //   Navigator.pop(context);
                                    //   Helper.showCustomSnackBar(context,
                                    //     content:
                                    //         AppLocalizations.of(context)!.PlaylistDeleted,
                                    //     bgColor: Colors.red,
                                    //     textColor: Colors.white);
                                    // });
                                  }
                                },
                              ),
                            ),
                          Spacer(),
                          Center(
                            child: Text(
                                isUpdate ? 'Edit Playlist' : 'Add Playlist',
                                style: Theme.of(context).textTheme.headline3),
                          ),
                          Spacer(),
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: AppColors.appMainColors,
                            child: IconButton(
                              icon: Icon(
                                isUpdate ? Icons.check : Icons.playlist_add,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (isUpdate) {
                                    Playlist model = Playlist(
                                      userId: userId,
                                      title: titleController.text,
                                      description: descriptionController.text,
                                    );

                                    model.title = playlistTitle;

                                    cubit.updatePlaylist(model).then((value) {
                                      cubit.getPlaylists();
                                      Navigator.pop(context);
                                      showCustomSnackBar(
                                          context,
                                          content:
                                              "Playlist Updated Successfully!",
                                          bgColor: Colors.green,
                                          textColor: Colors.white);
                                    });
                                  } else {
                                    Playlist model = Playlist(
                                      userId: userId,
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      datetime:
                                          DateTime.now().toIso8601String(),
                                    );

                                    cubit.addNewPlayList(model).then((value) {
                                      Navigator.pop(context);
                                      cubit.getPlaylists();
                                    });
                                  }
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                state is! GetPlaylistsLoadingState
                    ? Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Form(
                            key: formKey,
                            child: SingleChildScrollView(
                              physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  DefaultFormField(
                                    controller: titleController,
                                    label: 'Playlist Title',
                                    autoFocus: true,
                                    hintText: 'Playlist title',
                                    labelColor: Colors.grey[800],
                                    type: TextInputType.text,
                                    prefixColorIcon: Colors.grey[800],
                                    prefix: Icons.play_arrow_outlined,
                                    validate: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your title Playlist';
                                      } else if (currentPlaylistsNames
                                          .contains(value)) {
                                        return 'Title of playlist exist. Change it!';
                                      }
                                      return null;
                                    },
                                    borderColor: Colors.grey,
                                  ),
                                  const SizedBox(height: 10),
                                  DefaultFormField(
                                    controller: descriptionController,
                                    label: 'Playlist Description',
                                    type: TextInputType.text,
                                    prefixColorIcon: Colors.grey[800],
                                    labelColor: Colors.grey[800],
                                    minLines: 4,
                                    maxLines: 6,
                                    prefix: Icons.description_outlined,
                                    borderColor: Colors.grey,
                                  ),
                                  const SizedBox(height: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 50, top: 30),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: AppColors.appMainColors,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }
}
