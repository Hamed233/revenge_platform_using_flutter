import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:revenge_platform/components/constants/constants.dart';

class LoadingVideoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: LottieBuilder.asset(Resources.videoLoading,
            height: MediaQuery.of(context).size.height * 0.2),
      ),
    );
  }
}

class LoadingAppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: LottieBuilder.asset(Resources.appLoading,
            height: MediaQuery.of(context).size.height * 0.2),
      ),
    );
  }
}

class EmptyChatsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: LottieBuilder.asset(Resources.emptyChats,
            height: MediaQuery.of(context).size.height * 0.3),
      ),
    );
  }
}

class PeopleCommunicatingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: LottieBuilder.asset(Resources.peopleCommunicating,
            height: MediaQuery.of(context).size.height * 0.3),
      ),
    );
  }
}

class SendMessageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: LottieBuilder.asset(Resources.sendMessage,
            height: MediaQuery.of(context).size.height * 0.3),
      ),
    );
  }
}

class TwoPersonCommunicatingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: LottieBuilder.asset(Resources.twoPersonCommunicating,
            height: MediaQuery.of(context).size.height * 0.3),
      ),
    );
  }
}

class EmptyNotificationsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: LottieBuilder.asset(Resources.emptyNotifications,
            height: MediaQuery.of(context).size.height * 0.3),
      ),
    );
  }
}

class FailureWidget extends StatelessWidget {

  final String message;

  const FailureWidget({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(message);
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LottieBuilder.asset(Resources.error,
                  height: MediaQuery.of(context).size.height * 0.12),
              SizedBox(height: 20),
              Text(message, style: Theme.of(context).textTheme.bodyText1),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchWidget extends StatelessWidget {

  final searchIn;
  const SearchWidget({Key? key, required this.searchIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottieBuilder.asset(Resources.emptySearch,
                height: MediaQuery.of(context).size.height * 0.2),
            SizedBox(height: 20),
            Text("Search ${searchIn} Here", style: Theme.of(context).textTheme.bodyText1),
          ],
        ),
      ),
    );
  }
}

class ThinkingWidget extends StatelessWidget {

  const ThinkingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: LottieBuilder.asset(Resources.thinking,
                  height: MediaQuery.of(context).size.height * 0.2),
            ),
          ],
        ),
      ),
    );
  }
}

class GarbageWidget extends StatelessWidget {

  const GarbageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      child: Center(
        child: LottieBuilder.asset(Resources.garbage,
            height: MediaQuery.of(context).size.height * 0.2),
      ),
    );
  }
}
