import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdsCard extends StatelessWidget {
  const AdsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 0,
              margin: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  const Image(
                    image: NetworkImage(
                        "https://images.unsplash.com/photo-1537731121640-bc1c4aba9b80?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8N3x8YWRzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=600&q=60"),
                    fit: BoxFit.cover,
                    height: 200,
                    width: double.infinity,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadiusDirectional.circular(5),
                    ),
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Ads",
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
                            color: Colors.white,
                            fontFamily: 'Monadi',
                            fontSize: 14,
                          ),
                    ),
                  ),
                ],
              )),
          const SizedBox(
            height: 5,
          ),
          Container(
                height: 95.0,
                margin: const EdgeInsets.only(left: 08),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: const Text(
                        "Albashmoparmeg",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 17.0,
                            fontFamily: 'Roboto-Bold',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 03.0),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          const Text(
                            "Company Name",
                            style:  TextStyle(
                                fontSize: 15.0,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                   
                  ],
                ),
              ),
        ],
      ),
    );
  }
}