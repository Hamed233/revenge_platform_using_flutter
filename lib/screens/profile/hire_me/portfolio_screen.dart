import 'package:flutter/material.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text("Portfolio • Hamed Esam"),
        titleSpacing: 0,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          _portfolioSection(context),
        ],
      ),
    );
  }

  Widget _portfolioItemBuilder(context) {
    return Container(
      width: double.infinity,
      child: InkWell(
        onTap: () {},
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
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
                  "Website ui Website Website Website Website Website Website Website",
                  style: Theme.of(context).textTheme.headline3,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _portfolioSection(context) {
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
                "Portfolio items",
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            const Divider(
              thickness: 1,
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (BuildContext context, index) =>
                  _portfolioItemBuilder(context),
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
