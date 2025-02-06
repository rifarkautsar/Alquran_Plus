// import 'package:alquran_plus/widget/custom_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   LoginPageState createState() => LoginPageState();
// }

// class LoginPageState extends State<LoginPage> {
//   bool _isPasswordVisible = false; // Untuk kolom password
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   Future<void> loginUser() async {
//     final String apiUrl =
//         "https://41ma4c9p86.execute-api.ap-southeast-1.amazonaws.com/v1/login";

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: json.encode({
//           "email": emailController.text,
//           "password": passwordController.text,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(data['message'])),
//           );
//         }
//         // Lakukan sesuatu setelah login berhasil, seperti navigasi
//       } else {
//         final error = json.decode(response.body);
//         if (mounted) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text(error['message'])),
//           );
//         }
//       }
//     } catch (e) {
//       if (mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error: $e")),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         title: 'Sign In',
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Center(
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [const Color(0xFF6AB16D), const Color(0xFF52B957)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 6,
//                   offset: Offset(5, 5),
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(15),
//             ),
//             padding: EdgeInsets.all(20),
//             margin: EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(
//                   'Welcome Back',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 TextField(
//                   controller: emailController,
//                   style: TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.email, color: Colors.white),
//                     labelText: 'Masukkan Email',
//                     labelStyle: TextStyle(color: Colors.white60, fontSize: 14),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                 ),
//                 SizedBox(height: 20),
//                 TextField(
//                   controller: passwordController,
//                   obscureText:
//                       !_isPasswordVisible, // Password visibility toggle
//                   style: TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.lock, color: Colors.white),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isPasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.white70,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isPasswordVisible = !_isPasswordVisible;
//                         });
//                       },
//                     ),
//                     labelText: 'Masukkan Password',
//                     labelStyle: TextStyle(color: Colors.white60, fontSize: 14),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 70),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Implementasi autentikasi Google di sini
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(right: 10),
//                         child: Image.asset(
//                           'assets/images/icon_google.png', // Pastikan Anda memiliki file ini di folder `assets/`
//                           height: 20,
//                           width: 20,
//                         ),
//                       ),
//                       Text(
//                         'Sign In with Google',
//                         style: TextStyle(color: Colors.black, fontSize: 14),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 25),
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                   ),
//                   child: Text(
//                     'Sign Up',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'dart:convert';

// // class LoginPage extends StatefulWidget {
// //   const LoginPage({super.key});

// //   @override
// //   LoginPageState createState() => LoginPageState();
// // }

// // class LoginPageState extends State<LoginPage> {
// //   final TextEditingController emailController = TextEditingController();
// //   final TextEditingController passwordController = TextEditingController();

// //   Future<void> loginUser() async {
// //     final String apiUrl =
// //         "https://41ma4c9p86.execute-api.ap-southeast-1.amazonaws.com/v1/login";

// //     try {
// //       final response = await http.post(
// //         Uri.parse(apiUrl),
// //         headers: {"Content-Type": "application/json"},
// //         body: json.encode({
// //           "email": emailController.text,
// //           "password": passwordController.text,
// //         }),
// //       );

// //       if (response.statusCode == 200) {
// //         final data = json.decode(response.body);
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text(data['message'])),
// //         );
// //         // Lakukan sesuatu setelah login berhasil, seperti navigasi
// //       } else {
// //         final error = json.decode(response.body);
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           SnackBar(content: Text(error['message'])),
// //         );
// //       }
// //     } catch (e) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text("Error: $e")),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text("Login")),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           children: [
// //             TextField(
// //               controller: emailController,
// //               decoration: InputDecoration(labelText: "Email"),
// //               keyboardType: TextInputType.emailAddress,
// //             ),
// //             TextField(
// //               controller: passwordController,
// //               decoration: InputDecoration(labelText: "Password"),
// //               obscureText: true,
// //             ),
// //             SizedBox(height: 20),
// //             ElevatedButton(
// //               onPressed: loginUser,
// //               child: Text("Login"),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
