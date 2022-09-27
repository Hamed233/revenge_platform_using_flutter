import 'package:flutter/material.dart';
import 'package:revenge_platform/components/mini-video-component.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/test_json_data.dart';

class PlaylistDetails extends StatelessWidget {
  const PlaylistDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Playlist title'),
        titleSpacing: 0,
        actions: [
          IconButton(
              onPressed: () {
                // showMoreDetailsVideosBottomSheet(context);
              },
              icon: Icon(Icons.more_vert)),
        ],
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(10),
                  color: Colors.white
                ),
                child: Row(
                  children: [
                    Container(
                      width: (MediaQuery.of(context).size.width - 50) / 2.5,
                      height: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        // if post: put profile image, video: put thumnail image
                        child: Image(
                          image: NetworkImage(
                              "https://yt3.ggpht.com/ytc/AAUvwnjcXhQ1Tl-tCyXrovuQwBMHrFwE9uMzzclq2SzHjg=s176-c-k-c0xffffffff-no-rj-mo"),
                          fit: BoxFit.cover,
                        ),
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
                            alignment: Alignment.center,
                            width: (MediaQuery.of(context).size.width) * 0.5,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Playlist titlet itleti tle title title ffgfgfgfgf",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.9),
                                      fontWeight: FontWeight.w500,
                                      height: 1.3,
                                      fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  "Playlist description",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.9),
                                      fontWeight: FontWeight.w400,
                                      height: 1.3,
                                      fontSize: 14),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 10,),
                                Text(
                                   home_video_detail[0]['view_count'] +
                                    " views" + " • 30 items",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.4),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                  overflow: TextOverflow.ellipsis,
                                ),

                                SizedBox(height: 15,),
                                
                                Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () {}, 
                                      child: Icon(
                                        Icons.save_outlined,
                                        size: 27,
                                        color: Colors.grey.shade700,
                                      )
                                    ),
                                  ],
                                ),
                              ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                   
                  ],
                ),
              ),

              const SizedBox(height: 20,),
              Text(
                "Videos",
                style: Theme.of(context).textTheme.headline3,
              ),
              const SizedBox(height: 20,),

              Column(
                children: List.generate(home_video_detail.length, (index) {
                  return MiniVideoComponent();
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
