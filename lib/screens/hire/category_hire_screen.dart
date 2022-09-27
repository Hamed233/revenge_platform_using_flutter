import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:line_icons/line_icons.dart';
import 'package:revenge_platform/components/random_components.dart';
import 'package:revenge_platform/components/styles/colors.dart';
import 'package:revenge_platform/components/widgets/profile_image_with_status.dart';
import 'package:revenge_platform/components/widgets/search_field.dart';

class CategoryHireScreen extends StatelessWidget {
  const CategoryHireScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text("Programmer"),
        titleSpacing: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(LineIcons.filter)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
              shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 5.0, end: 5.0),
              child: SearchField(
                controller: searchController,
                hintText: "Search for programmer",
                borderColor: AppColors.appMainColors,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (context, int index) => _cardBuilder(context),
              itemCount: 5,
            ),
          ],
        ),
      ),
    );
  }

  Widget _tagBuilder(context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsetsDirectional.all(5),
        decoration: BoxDecoration(
            border: Border.all(
          color: AppColors.appMainColors,
        )),
        child: Text(
          "#Programmer",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.blue),
        ),
      ),
    );
  }

  Widget _cardBuilder(context) {
    return InkWell(
      onTap: () {},
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileImageWithStatus(),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                // flex: 3,
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
                      height: 5,
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
                          " • 122 reviews",
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        _tagBuilder(context),
                        const SizedBox(
                          width: 4,
                        ),
                        _tagBuilder(context),
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
                    Text(
                      "\$40 per hour",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    const SizedBox(
                      height: 9,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        // child:
                        //     filledBtn(10.0, "Hire", Colors.blue, Colors.white)
                        ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
