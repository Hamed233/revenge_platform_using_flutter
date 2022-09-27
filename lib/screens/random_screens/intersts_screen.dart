// import 'package:flutter/material.dart';

// // final List<String> artsInterests = [
// //   blah blah blah
// // ];


// // class ArtsInterests extends StatelessWidget {
// //   const ArtsInterests({
// //     Key? key,
// //     required this.artsInterests,
// //   }) : super(key: key);

// //   final List<String> artsInterests;

// //   @override
// //   Widget build(BuildContext context) {
// //   final height = MediaQuery.of(context).size.height;
// //   final width = MediaQuery.of(context).size.width;

// //     return Column(children: [
// //       Container(
// //         margin: EdgeInsets.only(
// //             left: width * 0.045,
// //             top: height * 0.033),
// //         child: Align(
// //             alignment: Alignment.centerLeft,
// //             child: Text(
// //               '🎨 Arts',
// //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
// //             )),
// //       ),
// //       Column(
// //         children: [
// //           Padding(
// //             padding: EdgeInsets.only(
// //                 left: width * 0.03,
// //                 top: height * 0.012),
// //             child: Container(
// //               width: width,
// //               height: height * 0.045,
// //               child: ListView.builder(
// //                   shrinkWrap: true,
// //                   scrollDirection: Axis.horizontal,
// //                   padding: const EdgeInsets.all(1),
// //                   itemCount: 7,
// //                   itemBuilder: (context, int index) {
// //                     return Interests2(AvailableInterestChosen(
// //                       artsInterests[index],
// //                       isChosen: false,
// //                     ));
// //                   }),
// //             ),
// //           ),
// //           Padding(
// //             padding: EdgeInsets.only(
// //                 left: width * 0.03,
// //                 top: height * 0.003),
// //             child: Container(
// //               width: width,
// //               height: height * 0.045,
// //               child: ListView.builder(
// //                   shrinkWrap: true,
// //                   scrollDirection: Axis.horizontal,
// //                   padding: const EdgeInsets.all(1),
// //                   itemCount: artsInterests.length - 7,
// //                   itemBuilder: (context, int index) {
// //                     return Interests2(AvailableInterestChosen(
// //                       artsInterests[7 + index],
// //                       isChosen: false,
// //                     ));
// //                   }),
// //             ),
// //           ),
// //         ],
// //       ),
// //     ]);
// //   }
// // }

// List<String> chosenInterests = [ "🏡 Home-body",  "🏃‍♀️ Running", "🧘🏻‍♀️ Yoga",  "🎭 Theaters",  "😸 Anime & Manga",];

// List<String> chosenArtsInterests = [];

// class Interests2 extends StatefulWidget {
//   final AvailableInterestChosen viewInterest = AvailableInterestChosen("test");

//   Interests2();

//   String id = 'Interests2';

//   @override
//   Interests2State createState() => Interests2State();
// }

// class Interests2State extends State<Interests2> {
//   @override
//   Widget build(BuildContext context) {
// final height = MediaQuery.of(context).size.height;
// final width = MediaQuery.of(context).size.width;
//     Container container = Container(
//         height: height * 0.03,
//         padding: EdgeInsets.symmetric(
//             horizontal: width * 0.027,
//             vertical:height * 0.003),
//         // padding: EdgeInsets.fromLTRB(12, 6, 12, 6),
//         margin: EdgeInsets.fromLTRB(
//           width * 0.012,
//           height * 0.003,
//           width * 0.012,
//           height * 0.003),
//         decoration: BoxDecoration(
//           color: widget.viewInterest.isChosen && chosenInterests.length < 9
//               ? Color(0xff0B84FE)
//               : Colors.white.withOpacity(0.87),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.69),
//               spreadRadius: 1,
//               blurRadius: 3,
//               offset: Offset(0, 1), // changes position of shadow
//             ),
//           ],
//           borderRadius: BorderRadius.circular(9),
//         ),
//         child: Text(
//           '${widget.viewInterest.title}',
//           style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w600,
//               color: widget.viewInterest.isChosen && chosenInterests.length < 9
//                   ? Colors.white
//                   : Colors.black),
//         ));

//     // if (widget.viewInterest.isChosen && chosenInterests.length < 9) {
//     //   chosenArtsInterests.add('${widget.viewInterest.title}');
//     //   var chosenInterests = chosenSportsInterests +
//     //       chosenEntertainmentInterests +
//     //       chosenCharacterInterests +
//     //       chosenArtsInterests +
//     //       chosenWellnessInterests +
//     //       chosenLanguageInterests;

//     //   print(chosenInterests);
//     // } else {
//     //   chosenArtsInterests.remove('${widget.viewInterest.title}');
//     //   var chosenInterests = chosenSportsInterests +
//     //       chosenEntertainmentInterests +
//     //       chosenCharacterInterests +
//     //       chosenArtsInterests +
//     //       chosenWellnessInterests +
//     //       chosenLanguageInterests;

//     //   print(chosenInterests);
//     // }
//     return Scaffold(
//       body: GestureDetector(
//         onTap: () {
//           setState(() {
//             widget.viewInterest.isChosen = !widget.viewInterest.isChosen;
//           });
//         },
//         child: container,
//       ),
//     );
//   }
// }


