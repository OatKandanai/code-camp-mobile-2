// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_firebase_app/app/home.dart';
// import 'package:flutter_firebase_app/app/register.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   // Sign in with Email & Password
//   Future<void> _signInWithEmailPassword() async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: _emailController.text.trim(),
//         password: _passwordController.text.trim(),
//       );
//       goHome();
//     } catch (e) {
//       _showMessage('Error: ${e.toString()}');
//     }
//   }

//   // Sign in with Google
//   Future<void> _signInWithGoogle() async {
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       if (googleAuth == null) return;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await _auth.signInWithCredential(credential);
//       goHome();
//     } catch (e) {
//       _showMessage('Google Sign-In Failed: ${e.toString()}');
//     }
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(
//       context,
//     ).showSnackBar(SnackBar(content: Text(message)));
//   }

//   Future<void> goHome() async {
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute<void>(builder: (BuildContext context) => Home()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Login")),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FlutterLogo(),
//               SizedBox(height: 20),
//               TextField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: "Email"),
//               ),
//               TextField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: "Password"),
//                 obscureText: true,
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: _signInWithEmailPassword,
//                 child: Text("Login with Email"),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: _signInWithGoogle,
//                 child: Text("Login with Google"),
//               ),
//               SizedBox(height: 10),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute<void>(
//                       builder: (BuildContext context) => const RegisterScreen(),
//                     ),
//                   );
//                 },
//                 child: Text("Register"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
