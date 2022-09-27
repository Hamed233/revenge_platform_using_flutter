import 'package:flutter/material.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/profile_image_with_status.dart';
import 'package:revenge_platform/screens/profile/hire_me/portfolio_screen.dart';
import 'package:revenge_platform/screens/profile/hire_me/reviews_screen.dart';

class HireMeTab extends StatefulWidget {
  @override
  HireMeTabState createState() => HireMeTabState();
}

class HireMeTabState extends State<HireMeTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        _hireMeBTNSection(),
        _skillsSection(),
        _portfolioSection(),
        _reviewSection(),
      ],
    );
  }

  Widget _portfolioItemBuilder() {
    return Container(
      width: 230,
      height: 120,
      child: InkWell(
        onTap: () {},
        child: Card(
          child: Column(
            children: [
              Image(
                width: double.infinity,
                height: 200,
                image: NetworkImage(
                    "https://images.pexels.com/photos/776656/pexels-photo-776656.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Website ui",
                  style: Theme.of(context).textTheme.headline3,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _portfolioSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
              child: Row(
                children: [
                  Text(
                    "Portfolio items",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Spacer(),
                  TextButton(onPressed: () {
                    navigateTo(context, PortfolioScreen());
                  }, child: Text("more"))
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Container(
              width: double.infinity,
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, index) =>
                    _portfolioItemBuilder(),
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

  Widget _reviewItemBuilder() {
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
                        "Java ProjectProjectProjectProject ProjectProjectProject Project",
                        style: Theme.of(context).textTheme.headline3,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // const Spacer(),
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
                  maxLines: 5,
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

  Widget _reviewSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 8.0, end: 8.0),
              child: Row(
                children: [
                  Text(
                    "Reviews",
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  Spacer(),
                  TextButton(onPressed: () {
                    navigateTo(context, ReviewsScreen());
                  }, child: Text("more"))
                ],
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, index) =>
                  _reviewItemBuilder(),
              separatorBuilder: (context, index) {
                return Divider(
                  height: 50,
                  thickness: 1,
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _skillItemBuilder() {
    return Container(
      color: Colors.grey[200],
                padding: const EdgeInsetsDirectional.only(top: 3, bottom: 3, start: 5, end: 5),
      child: Text(
        "python",
        style: Theme.of(context).textTheme.headline4!.copyWith(
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _skillsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 10.0, end: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(top: 8.0, bottom: 8.0),
              child: Text(
                "Top Skills",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            Container(
              width: double.infinity,
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: 22,
                itemBuilder: (BuildContext context, index) =>
                    _skillItemBuilder(),
                separatorBuilder: (context, index) {
                  return const Padding(padding: EdgeInsetsDirectional.only(end: 5));
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

  Widget _hireMeBTNSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: filledBtn(10.0, "Hire me", AppColors.appMainColors, Colors.white),
      ),
    );
  }

}
