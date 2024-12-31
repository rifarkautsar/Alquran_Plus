// import 'package:alquran_plus/widget/custom_appbar.dart';
// import 'package:alquran_plus/widget/menu.dart';
// import 'package:flutter/material.dart';

// class Beranda extends StatelessWidget {
//   const Beranda({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: CustomAppBar(title: 'Alquran Plus', actions: [
//           IconButton(
//             icon: const Icon(Icons.search, color: Colors.white),
//             onPressed: () {
//               // Implement search functionality
//             },
//           ),
//           IconButton(
//             icon: const Icon(Icons.notifications, color: Colors.white),
//             onPressed: () {
//               // Implement notification functionality
//             },
//           ),
//         ]),
//         drawer: Menu(),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Text("Welcome & Enjoy To Alquran Plus",style:
//                   TextStyle(
//                     fontSize: 30,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF3DC185),

//                   ),),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
