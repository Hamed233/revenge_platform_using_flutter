import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:revenge_platform/test_json_data.dart';

class MiniVideoComponent extends StatelessWidget {
  const MiniVideoComponent({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
              onTap: () {
                // _startPlay(home_video_detail[0]);
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: (MediaQuery.of(context).size.width - 50) / 2,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: AssetImage(
                                  home_video_detail[0]['thumnail_img']),
                              fit: BoxFit.cover)),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            bottom: 10,
                            right: 12,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(3)),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  home_video_detail[0]['video_duration'],
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white.withOpacity(0.4)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            width:
                                (MediaQuery.of(context).size.width - 150) / 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  home_video_detail[0]['title'],
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.9),
                                      fontWeight: FontWeight.w500,
                                      height: 1.3,
                                      fontSize: 14),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                   home_video_detail[0]['view_count'] +
                                    " views",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(height: 5,),
                                Text(
                                    home_video[1]['day_ago'],
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              
                              ],
                            ),
                          ),
                          Icon(
                            LineIcons.verticalEllipsis,
                            color: Colors.black.withOpacity(0.4),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            );
  }
}