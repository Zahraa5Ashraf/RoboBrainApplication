// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/material.dart';
// import 'package:healthcare/views/HomePage.dart';

// import '../constants.dart';
// import 'login/components/body.dart';

// class map extends StatefulWidget {
//   static List<dynamic> activities = [];

//   const map({super.key});

//   @override
//   State<map> createState() => _mapState();
// }

// class _mapState extends State<map> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(
//         top: 20,
//       ),
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/images/animatedbackground.gif'),
//             fit: BoxFit.cover),
//         // gradient: LinearGradient(
//         //     begin: Alignment.topLeft,
//         //     end: Alignment.bottomRight,
//         //     colors: [kPrimary2, Colors.white]),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: Padding(
//           padding: const EdgeInsets.only(
//             top: 30.0,
//           ),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Row(
//               children: [
//                 IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => HomePage(
//                           Age: globalage,
//                           Username: globalusername,
//                           Gender: globalgender,
//                         ),
//                       ),
//                     );
//                   },
//                   icon: Icon(
//                     Icons.arrow_back_ios,
//                     color: Colors.white,
//                   ),
//                 ),
//                 Text(
//                   "Map",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(50),
//                   topRight: Radius.circular(50),
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.only(
//                     top: 25,
//                     //  left: 25,
//                     // right: 25,
//                   ),
//                   color: Colors.white,
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 60,
//                       ),
//                       Center()
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
