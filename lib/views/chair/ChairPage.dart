// // ignore_for_file: file_names, use_build_context_synchronously

// import 'package:flutter/material.dart';

// import 'package:healthcare/constants.dart';
// import 'package:healthcare/views/HomePage.dart';
// import 'package:healthcare/views/chair/chair.dart';
// import 'package:healthcare/views/login/components/body.dart';
// //import 'dart:convert';
// //import 'package:http/http.dart' as http;
// import '../login/components/roundedbutton.dart';

// class ChairPage extends StatefulWidget {
//   final CardItem item;
//   const ChairPage({
//     Key? key,
//     required this.item,
//   }) : super(key: key);

//   @override
//   State<ChairPage> createState() => _ChairPageState();
// }

// class _ChairPageState extends State<ChairPage> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     // style button important
//     final ButtonStyle flatbuttonstyle = TextButton.styleFrom(
//       padding: const EdgeInsets.symmetric(
//         vertical: 20,
//         horizontal: 40,
//       ),
//       backgroundColor: kPrimaryColor,
//     );
//     //style button important
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColor,
//         title: const Text('WheelChair details'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(40.0),
//         child: Column(
//           children: [
//          const   SizedBox(
//               height: 70,
//             ),
//             ClipRRect(
//               borderRadius: BorderRadius.circular(20),
//               child: Container(
//                 color: Colors.white,
//                 child: AspectRatio(
//                   aspectRatio: 4 / 4,
//                   child: Image.asset(
//                     widget.item.urlImage,
//                     //fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Text(
//               widget.item.title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: kPrimaryColor,
//                 fontSize: 35,
//               ),
//             ),
//             Text(
//               widget.item.subtitle,
//               style:  const TextStyle(
//                 color: Colors.grey,
//                 fontSize: 25,
//               ),
//             ),
//         const    Text(
//               'Patient Details:   etc',
//               style: TextStyle(
//                 color: Colors.grey,
//                 fontSize: 20,
//               ),
//             ),
//             const Spacer(),
//             roundedbutton(
//                 size: size,
//                 flatbuttonstyle: flatbuttonstyle,
//                 text: 'Enter ',
//                 textcolor: Colors.white,
//                 press: () {
//                   reload();
//                 })
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> reload() async {
//     await Future.delayed ( const Duration(seconds: 3));

//     Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) => HomePage(
//                   Age: globalage,
//                   Gender: globalgender,
//                   Username: globalusername,
//                 )));
//     return;
//   }
// }
