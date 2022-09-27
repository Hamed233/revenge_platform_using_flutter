import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ChannelLogo extends StatefulHookWidget {
  const ChannelLogo({Key? key,
  //  this.channel, 
   this.size = 60}) : super(key: key);

  // final AsyncSnapshot<Channel>? channel;
  final double size;

  @override
  State<ChannelLogo> createState() => _ChannelLogoState();
}

class _ChannelLogoState extends State<ChannelLogo>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // final channelHasData = widget.channel != null && widget.channel!.hasData;
    // final channelData = channelHasData ? widget.channel!.data : null;
    final Color bgColor =
        Colors.primaries[Random().nextInt(Colors.primaries.length)];

    final Widget defaultPlaceholder = Container(
      width: widget.size,
      height: widget.size,
      color: bgColor,
      child: Center(
        child: Text(
          // channelHasData ? channelData!.title.characters.first : '...',
          '...',
          style: Theme.of(context).textTheme.headline5!.copyWith(
            fontWeight: FontWeight.w500,
            color:
                bgColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
    return ClipOval(
      // child: channelHasData
      child: CachedNetworkImage(
              width: widget.size,
              height: widget.size,
              imageUrl: "https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909__340.png",
              errorWidget: (_, __, dynamic ___) => defaultPlaceholder,
              placeholder: (_, __) => defaultPlaceholder,
              fit: BoxFit.contain,
            )
          // : defaultPlaceholder,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
