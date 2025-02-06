// // ignore_for_file: use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   RegisterPageState createState() => RegisterPageState();
// }

// class RegisterPageState extends State<RegisterPage> {
//   bool _isPasswordVisible = false;
//   bool _isConfirmPasswordVisible = false;
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController =
//       TextEditingController();

//   Future<void> registerUser() async {
//     final String apiUrl =
//         "https://41ma4c9p86.execute-api.ap-southeast-1.amazonaws.com/v1/register";

//     // Validasi input
//     if (emailController.text.isEmpty ||
//         passwordController.text.isEmpty ||
//         confirmPasswordController.text.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("All fields are required")),
//       );
//       return;
//     }

//     if (passwordController.text != confirmPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Passwords do not match")),
//       );
//       return;
//     }

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: json.encode({
//           "email": emailController.text,
//           "password": passwordController.text,
//           "confirm_password": confirmPasswordController.text,
//         }),
//       );

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(data['message'])),
//         );
//         // Navigasi setelah berhasil registrasi
//         Navigator.pop(context);
//       } else {
//         final error = json.decode(response.body);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(error['message'])),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Up'),
//         backgroundColor: const Color(0xFF6AB16D),
//       ),
//       body: Container(
//         color: Colors.white,
//         child: Center(
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFF6AB16D), Color(0xFF52B957)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 6,
//                   offset: Offset(5, 5),
//                 ),
//               ],
//               borderRadius: BorderRadius.circular(15),
//             ),
//             padding: const EdgeInsets.all(20),
//             margin: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Text(
//                   'Create Account',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: emailController,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.email, color: Colors.white),
//                     labelText: 'Email',
//                     labelStyle: const TextStyle(color: Colors.white60),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: passwordController,
//                   obscureText: !_isPasswordVisible,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock, color: Colors.white),
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
//                     labelText: 'Password',
//                     labelStyle: const TextStyle(color: Colors.white60),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 TextField(
//                   controller: confirmPasswordController,
//                   obscureText: !_isConfirmPasswordVisible,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: InputDecoration(
//                     prefixIcon: const Icon(Icons.lock, color: Colors.white),
//                     suffixIcon: IconButton(
//                       icon: Icon(
//                         _isConfirmPasswordVisible
//                             ? Icons.visibility
//                             : Icons.visibility_off,
//                         color: Colors.white70,
//                       ),
//                       onPressed: () {
//                         setState(() {
//                           _isConfirmPasswordVisible =
//                               !_isConfirmPasswordVisible;
//                         });
//                       },
//                     ),
//                     labelText: 'Confirm Password',
//                     labelStyle: const TextStyle(color: Colors.white60),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 25),
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
//                   onPressed: registerUser,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 40, vertical: 15),
//                   ),
//                   child: const Text(
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
