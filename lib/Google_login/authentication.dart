// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// //0f:54:4d:2a:62:11:8b:8a:09:12:73:dc:36:1b:bf:36:9b:de:77:44
// class Authentication {
//   static Future<User?> signInWithGoogle({required BuildContext context}) async {
//     FirebaseAuth auth = FirebaseAuth.instance;
//     User? user;

//     final GoogleSignIn googleSignIn = GoogleSignIn();

//     final GoogleSignInAccount? googleSignInAccount =
//         await googleSignIn.signIn();

//     if (googleSignInAccount != null) {
//       final GoogleSignInAuthentication googleSignInAuthentication =
//           await googleSignInAccount.authentication;

//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleSignInAuthentication.accessToken,
//         idToken: googleSignInAuthentication.idToken,
//       );

//       try {
//         final UserCredential userCredential =
//             await auth.signInWithCredential(credential);

//         user = userCredential.user;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'account-exists-with-different-credential') {
//           // handle the error here
//           ScaffoldMessenger.of(context).showSnackBar(
//             Authentication.customSnackBar(
//               content:
//                   'The account already exists with a different credential.',
//             ),
//           );
//         } else if (e.code == 'invalid-credential') {
//           // handle the error here
//           ScaffoldMessenger.of(context).showSnackBar(
//             Authentication.customSnackBar(
//               content: 'Error occurred while accessing credentials. Try again.',
//             ),
//           );
//         }
//       } catch (e) {
//         // handle the error here
//         ScaffoldMessenger.of(context).showSnackBar(
//           Authentication.customSnackBar(
//             content: 'Error occurred using Google Sign-In. Try again.',
//           ),
//         );
//       }

//       return user;
//     }
//   }

//   static SnackBar customSnackBar({required String content}) {
//     return SnackBar(
//       backgroundColor: Colors.black,
//       content: Text(
//         content,
//         style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
//       ),
//     );
//   }
// }
