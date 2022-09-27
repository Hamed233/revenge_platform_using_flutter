import 'package:flutter/material.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/widgets/profile_image_with_status.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text("Reviews • Hamed Esam"),
        titleSpacing: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          _reviewSection(context),
        ],
      ),
    );
  }

    Widget _reviewItemBuilder(context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileImageWithStatus(),
          const SizedBox(
            width: 8,
          ),
          Expanded(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hamed essam",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    // Text(
                    //   countryFlag(),
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "Programmer, freelancer, coder",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Java Project Proje ctProj ectProject Proje ctProje ctPro ject Project",
                        style: Theme.of(context).textTheme.headline3,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Text(
                      "\$130 USD",
                      style: Theme.of(context).textTheme.headline4,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 9,
                ),
                Text(
                  "Quality of work is my first priority I am Rupa Gupta, Creative Freelance Graphic designer with over 7 years of experience in the field and member of Preferred Freelancer Program. Dedicated to staying up-to-date on new techniques and procedures associated with graphic design. Excel at Logo design, layout... ",
                  style: Theme.of(context)
                      .textTheme
                      .caption!
                      .copyWith(fontSize: 13),
                  maxLines: 15,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                ),
                const SizedBox(
                  height: 9,
                ),
                Row(
                  children: [
                    Container(
                      color: Colors.amber,
                      padding: EdgeInsetsDirectional.only(
                          start: 5, end: 5, top: 4, bottom: 4),
                      child: Text(
                        "4.9",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Row(
                      children: [
                        // reviewStar,
                        // reviewStar,
                        // reviewStar,
                        // reviewStar,
                        // reviewStar,
                      ],
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      " •  2 days ago",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.grey),
                    )
                  ],
                ),
              ]))
        ]);
  }

  Widget _reviewSection(context) {
    return Card(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 10.0, bottom: 10),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, index) =>
                    _reviewItemBuilder(context),
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 50,
                    thickness: 1,
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

}