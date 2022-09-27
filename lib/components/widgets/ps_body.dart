import 'package:flutter/material.dart';
import 'package:revenge_platform/components/widgets/size_expanded_section.dart';
import 'package:revenge_platform/controller/internet_connectivity.dart';

class SFBody extends StatelessWidget {
  const SFBody({
    Key? key,
    required this.child,
    this.expanded = true,
  }) : super(key: key);

  final Widget child;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const NetStatus(),
        // if (expanded) Expanded(child: child) else child,
      ],
    );
  }
}

class NetStatus extends StatelessWidget {
  const NetStatus({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: true,
      stream: InternetConnectivity.networkStream,
      builder: (context, snapshot) {
        return Stack(
          children: [
            SizeExpandedSection(
              expand: snapshot.data == NetworkStatus.offline,
              child: Container(
                width: double.infinity,
                color: Colors.redAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "networkLostShowingCachedData",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizeExpandedSection(
              expand: snapshot.data == NetworkStatus.restored,
              child: Container(
                width: double.infinity,
                color: Colors.green[600],
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Center(
                    child: Text(
                      "backOnline",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
