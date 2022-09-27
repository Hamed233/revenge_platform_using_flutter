import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:im_stepper/stepper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:revenge_platform/blocs/video_bloc/states.dart';
import 'package:revenge_platform/blocs/video_bloc/video_bloc.dart';
import 'package:revenge_platform/components/constants/constants.dart';
import 'package:revenge_platform/components/default_form_field.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/date_button.dart';
import 'package:revenge_platform/models/video_settings.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:video_player/video_player.dart';

class UploadVideo extends StatefulWidget {
  const UploadVideo({Key? key}) : super(key: key);

  @override
  _UploadVideoState createState() => _UploadVideoState();
}

class _UploadVideoState extends State<UploadVideo>
    with SingleTickerProviderStateMixin {
  late AnimationController loadingVideoController;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final DateRangePickerController dateController = DateRangePickerController();

  int activeStep = 0; // Initial step set to 5.
  int upperBound = 3;

  // File? _video;
  // final pickerVideo = ImagePicker();

  // selectVideo() async {
  //   final pickedFile = await pickerVideo.pickVideo(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     _video = File(pickedFile.path);
  //     // _videoPlayerController = VideoPlayerController.asset(pickedFile.path)..initialize();
  //     initializePlayer();
  //     loadingVideoController.forward();
  //   }
  // }

  @override
  void initState() {
    loadingVideoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..addListener(() {
        setState(() {});
      });
    VideoBloc.get(context).getPlaylists();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoBloc, VideoStates>(
      listener: (context, state) {
        if (state is VideoUploadingLoadingState) {
          loadingVideoController.forward();
        } else if (state is VideoPickedSuccessfullyState) {
        }
      },
      builder: (context, state) {
        VideoBloc cubit = VideoBloc.get(context);

        return Scaffold(
          body: Container(
            child: Column(
              children: <Widget>[
                // Stepper
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(top: 15.0),
                    child: IconStepper(
                      activeStepColor: Colors.white,
                      stepColor: Colors.grey.shade200,
                      enableStepTapping: cubit.video == null ? false : true,
                      enableNextPreviousButtons:
                          cubit.video == null ? false : true,
                      icons: [
                        Icon(
                          Icons.video_file_outlined,
                          color:
                              cubit.video == null ? Colors.black : Colors.green,
                        ),
                        const Icon(Icons.info_outline),
                        const Icon(Icons.settings),
                        const Icon(Icons.timer),
                      ],

                      // activeStep property set to activeStep variable defined above.
                      activeStep: activeStep,

                      // This ensures step-tapping updates the activeStep.
                      onStepReached: (index) {
                        setState(() {
                          activeStep = index;
                        });
                      },
                    ),
                  ),
                ),
                // Loading progress
                if (cubit.video != null)
                  LinearProgressIndicator(
                    color: AppColors.appMainColors,
                    value: loadingVideoController.value,
                  ),
                if (activeStep != 0)
                  const SizedBox(
                    height: 20,
                  ),
                // Content of tabs
                Expanded(
                  child: Container(
                    // height: MediaQuery.of(context).size.height * 0.8,
                    // color: Colors.amber,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          if (activeStep != 0 && cubit.video != null)
                            selectedVideoWidget(cubit),
                          if (activeStep == 0) uploadVideoWidget(cubit),
                          if (activeStep == 1 && cubit.video != null)
                            videoInformationWidget(cubit),
                          if (activeStep == 2 && cubit.video != null)
                            videoSettingsWidget(cubit),
                          if (activeStep == 3 && cubit.video != null)
                            publishWidget(cubit),
                          if (cubit.video != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 20.0),
                              child: Row(
                                mainAxisAlignment: activeStep != 0
                                    ? MainAxisAlignment.spaceBetween
                                    : MainAxisAlignment.end,
                                children: [
                                  // if (activeStep != 0)
                                  //   borderedBtn(10.0, "prev", 1.0,
                                  //       AppColors.appMainColors, onPressed: () {
                                  //     if (activeStep > 0) {
                                  //       setState(() {
                                  //         activeStep--;
                                  //       });
                                  //     }
                                  //   }),
                                  // if (activeStep != 3)
                                  //   filledBtn(
                                  //       10.0,
                                  //       "next",
                                  //       AppColors.appMainColors,
                                  //       Colors.white, onPressed: () {
                                  //     if (activeStep < upperBound) {
                                  //       setState(() {
                                  //         activeStep++;
                                  //       });
                                  //     }
                                  //   }),
                                  // if (activeStep == 3)
                                  //   filledBtn(
                                  //       10.0,
                                  //       cubit.isScaduale
                                  //           ? "Schedule"
                                  //           : "publish",
                                  //       AppColors.appMainColors,
                                  //       Colors.white, 
                                  //     onPressed: () {
                                  //       print(descriptionController.text);
                                  //     cubit.uploadVideo(
                                  //         titleController.text,
                                  //         descriptionController.text,
                                  //         cubit.selectedPlaylist,
                                  //         "programming",
                                  //         cubit.videoPlayerController!
                                  //             .value.duration.toString(),
                                  //         cubit.videoUrl,
                                  //         cubit.imageUrl,
                                  //         VideoSettings(
                                  //           closeComments: cubit.isClosed,
                                  //           closeFeedback: cubit.closedFeedback,
                                  //           suitableForChildren:
                                  //               cubit.suitableForChildren,
                                  //         ),
                                  //         userId);
                                    // }),
                                ],
                              ),
                            )
                        ],
                      ),
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

  Widget uploadVideoWidget(cubit) {
    return Column(
      children: [
        Container(
          child: LottieBuilder.asset(Resources.videoUploadMobile,
              height: MediaQuery.of(context).size.height * 0.5,
              width: double.infinity),
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          'Upload your video',
          style: TextStyle(
              fontSize: 25,
              color: Colors.grey.shade800,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          'File should be MP4, MOV',
          style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
        ),
        const SizedBox(
          height: 20,
        ),
        GestureDetector(
          onTap: cubit.selectAndUploadVideo,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [7, 4],
                strokeCap: StrokeCap.round,
                color: Colors.blue.shade400,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: cubit.video == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.video_file,
                              color: Colors.blue,
                              size: 40,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Select your video',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade400),
                            ),
                          ],
                        )
                      : Container(
                          width: double.infinity,
                          height: double.infinity,
                          // decoration: BoxDecoration(
                          //   image: DecorationImage(
                          //     image: FileImage(
                          //       cubit.video!,
                          //     ),
                          //     fit: BoxFit.cover,
                          //     colorFilter: ColorFilter.mode(
                          //         Colors.black.withOpacity(0.4),
                          //         BlendMode.darken),
                          //   ),
                          //   borderRadius: BorderRadius.circular(8),
                          // ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (loadingVideoController.value != 1.0)
                                CircularProgressIndicator(
                                  value: loadingVideoController.value,
                                  color: AppColors.appMainColors,
                                ),
                              if (loadingVideoController.value == 1.0)
                                SvgPicture.asset(Resources.complete,
                                    width: 60, height: 60),
                              const SizedBox(
                                height: 15,
                              ),
                              if (loadingVideoController.value != 1.0)
                                Text(
                                  "Uploading video...",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              if (loadingVideoController.value == 1.0)
                                Text(
                                  "Video Uploaded Successfully",
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                '${(cubit.video!.lengthSync() / 1024).ceil()} KB • ' +
                                    (loadingVideoController.value * 100)
                                        .toString() +
                                    "%",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                ),
              )),
        ),
      ],
    );
  }

  Widget videoInformationWidget(VideoBloc cubit) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Video Info',
              style: Theme.of(context).textTheme.headline3,
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Title",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            DefaultFormField(
              type: TextInputType.text,
              controller: titleController,
              validate: (value) {
                if (value == null || value.isEmpty || value.length > 100) {
                  return 'Please title must be it under 100 characters.';
                }
                return null;
              },
              borderColor: const Color.fromARGB(142, 177, 177, 177),
              hintText: "Video title",
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Description",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: DefaultFormField(
                type: TextInputType.text,
                textAlignVertical: TextAlignVertical.top,
                controller: descriptionController,
                validate: (value) {
                  if (value == null || value.isEmpty || value.length > 4000) {
                    return 'Please description must be under 4000 characters.';
                  }
                  return null;
                },
                borderColor: Color.fromARGB(142, 177, 177, 177),
                hintText: 'Write video description...',
                minLines: 9,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                  "Playlist",
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 15,
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    // showAddNewPlaylistBottomSheet(context);
                  },
                  child: Text(
                    "Add New",
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          color: AppColors.appMainColors,
                        ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsetsDirectional.only(start: 15.0, end: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(10),
                color: Colors.white,
              ),
              child: DropdownButton(
                underline: Container(
                  width: 0,
                ),
                isExpanded: true,
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Theme.of(context).cardColor,
                // onTap: () => Helper.unfocus(),
                onChanged: (val) {
                  cubit.selectPlaylist(val);
                },
                items: cubit.playlists.map(
                  (e) {
                    return DropdownMenuItem<String>(
                      value: e.title,
                      child: Text(
                        e.title!,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    );
                  },
                ).toList(),
                style: Theme.of(context).textTheme.bodyText2,
                value: cubit.selectedPlaylist,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Thumnail Image",
              style: TextStyle(
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: cubit.selectAndUploadThumn,
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: [7, 4],
                strokeCap: StrokeCap.round,
                color: Colors.blue.shade400,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50.withOpacity(.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: cubit.imageThumnail == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.image,
                              color: Colors.blue,
                              size: 40,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Select thumnail image',
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade400),
                            ),
                          ],
                        )
                      : Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(
                                cubit.imageThumnail!,
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ));
  }

  Widget videoSettingsWidget(VideoBloc cubit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Video Settings',
            style: Theme.of(context).textTheme.headline3,
          ),
          const SizedBox(
            height: 20,
          ),
          CheckboxListTile(
              contentPadding: const EdgeInsetsDirectional.all(0),
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "Close comments on this video?",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 15),
                textAlign: TextAlign.left,
              ),
              value: cubit.closedComments,
              onChanged: (bool? value) {
                cubit.toggleVideoSettings(value, "comments");
              }),
          CheckboxListTile(
              contentPadding: const EdgeInsetsDirectional.all(0),
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "Close send feedback on this video?",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 15),
                textAlign: TextAlign.left,
              ),
              value: cubit.closedFeedback,
              onChanged: (bool? value) {
                cubit.toggleVideoSettings(value, "feedback");
              }),
          CheckboxListTile(
              contentPadding: const EdgeInsetsDirectional.all(0),
              controlAffinity: ListTileControlAffinity.leading,
              title: Text(
                "Content suitable for children?",
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(fontSize: 15),
                textAlign: TextAlign.left,
              ),
              value: cubit.suitableForChildren,
              onChanged: (bool? value) {
                cubit.toggleVideoSettings(value, "suitableChildren");
              })
        ],
      ),
    );
  }

  Widget selectedVideoWidget(cubit) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Selected Video', style: Theme.of(context).textTheme.headline3),
          const SizedBox(
            height: 10,
          ),
          Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: Offset(0, 1),
                      blurRadius: 3,
                      spreadRadius: 2,
                    )
                  ]),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      height: 50,
                      width: 50,
                      child: AspectRatio(
                        aspectRatio:
                            cubit.videoPlayerController.value.aspectRatio,
                        child: cubit.imageThumnail != null
                            ? Image(
                                image: FileImage(cubit.imageThumnail),
                                fit: BoxFit.cover)
                            : VideoPlayer(cubit.videoPlayerController),
                      ),
                    ),
                  ),
                  // Image.file(
                  //   cubit.video!,
                  //   fit: BoxFit.cover,
                  //   height: 70,
                  //   width: 90,
                  // )
                  // ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cubit.video!.uri.pathSegments.last.toString(),
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${(cubit.video!.lengthSync() / 1024).ceil()} KB • ' +
                              (loadingVideoController.value * 100).toString() +
                              "%",
                          style: TextStyle(
                              fontSize: 13, color: Colors.grey.shade500),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                            height: 5,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.blue.shade50,
                            ),
                            child: LinearProgressIndicator(
                              color: AppColors.appMainColors,
                              value: loadingVideoController.value,
                            )),
                      ],
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  Widget publishWidget(VideoBloc cubit) {
    return Padding(
        padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Final Step', style: Theme.of(context).textTheme.headline3),
              SizedBox(
                height: 10,
              ),
              CheckboxListTile(
                  contentPadding: const EdgeInsetsDirectional.all(0),
                  controlAffinity: ListTileControlAffinity.leading,
                  title: Text(
                    "Schedule video?",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  value: cubit.isScaduale,
                  onChanged: (bool? value) {
                    cubit.toggleScaduale(value);
                  }),
              if (cubit.isScaduale)
                Container(
                  padding: EdgeInsetsDirectional.all(10),
                  margin: EdgeInsetsDirectional.only(start: 40),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade200,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(children: [
                        Text("Date: "),
                        const SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          flex: 1,
                          child: DateButton(
                            onTap: () {
                              showDialog<Widget>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return _datePicker(context, cubit: cubit);
                                  });
                            },
                            text: cubit.sceduleDate,
                            prefixWidget: Icon(
                              Icons.date_range,
                              color: Colors.green,
                              size: 15,
                            ),
                          ),
                        ),
                      ]),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(children: [
                        Text("Time: "),
                        const SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: DateButton(
                              onTap: () {
                                _selectTime(context, true, cubit: cubit);
                              },
                              text: cubit.sceduleTime.toString(),
                              prefixWidget: const Icon(
                                Icons.timer,
                                color: Colors.green,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                      ]),
                    ],
                  ),
                )
            ]));
  }

  _datePicker(context, {cubit}) {
    return Container(
      margin: EdgeInsetsDirectional.only(
          start: 10,
          end: 10,
          top: MediaQuery.of(context).size.height * 0.15,
          bottom: MediaQuery.of(context).size.height * 0.15),
      child: SfDateRangePicker(
        controller: dateController,
        headerHeight: 80,
        backgroundColor: Colors.white,
        showActionButtons: true,
        selectionMode: DateRangePickerSelectionMode.single,
        showNavigationArrow: true,
        minDate: DateTime(2020),
        maxDate: DateTime(2040),
        initialSelectedDate: DateTime.now(),
        view: DateRangePickerView.month,
        selectionTextStyle: const TextStyle(color: Colors.white),
        selectionColor: AppColors.appMainColors,
        startRangeSelectionColor: AppColors.appMainColors,
        endRangeSelectionColor: AppColors.appMainColors,
        rangeSelectionColor: AppColors.appMainColors.withOpacity(.9),
        todayHighlightColor: AppColors.appMainColors,
        rangeTextStyle: const TextStyle(color: Colors.white, fontSize: 20),
        headerStyle: DateRangePickerHeaderStyle(
            backgroundColor: AppColors.appMainColors,
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 25,
              letterSpacing: 5,
              color: Colors.white,
            )),
        monthViewSettings: DateRangePickerMonthViewSettings(
            dayFormat: 'EEE',
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
                backgroundColor: Colors.grey[500],
                textStyle: TextStyle(fontSize: 14, letterSpacing: 4))),
        onSubmit: (Object? value) {
          cubit.getVideoDate(value);
          Navigator.pop(context);
        },
        // onSelectionChanged: (DateRangePickerSelectionChangedArgs args) => cubit.getVideoDate(args),
        onCancel: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  _selectTime(BuildContext context, forStartTime, {cubit}) async {
    DateTime now = DateTime.now();
    // Convert (Start & End) time from string to datetime
    DateTime schaduleTimeAsDateTime = DateFormat.jm().parse(cubit.sceduleTime!);
    String schaduleTimeAs24Hours =
        DateFormat("HH:mm").format(schaduleTimeAsDateTime);
    // Finnaly: Convert (schadule & End) time from string to TimeOfDay (As 24 hours)
    TimeOfDay schaduleTimeAsTimeOfDay = TimeOfDay.now().replacing(
        hour: int.parse(
            schaduleTimeAs24Hours.split(' ').removeAt(0).split(":")[0]),
        minute: int.parse(
            schaduleTimeAs24Hours.split(' ').removeAt(0).split(":")[1]));

    TimeOfDay initialTime;

    initialTime = cubit.sceduleTime == null
        ? TimeOfDay(hour: now.hour, minute: now.minute)
        : schaduleTimeAsTimeOfDay;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: initialTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );

    if (time != null && time != cubit.sceduleTime) {
      cubit.getSchaduleTime(time.format(context));
    }
  }
}
