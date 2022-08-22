//import 'package:fashion_design/Google_login/gobal.dart';

import 'package:ecommerce_rah/Google_login/userProfile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../providers/tokenstoreprovider.dart';
import '../screens/bottomnav_bar.dart';

class LogginScreen extends StatefulWidget {
  @override
  State<LogginScreen> createState() => _LogginScreenState();
}

class _LogginScreenState extends State<LogginScreen> {
  bool signin = true;
  //String daa='hi';

  Future<User?> signInWithGoogle() async {
    try {
      //SIGNING IN WITH GOOGLE
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      //CREATING CREDENTIAL FOR FIREBASE
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      //SIGNING IN WITH CREDENTIAL & MAKING A USER IN FIREBASE  AND GETTING USER CLASS
      final userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      TokenProvider? tokenProvider;
      //CHECKING IS ON
      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);

      final User? currentUser = await _auth.currentUser;
      assert(currentUser!.uid == user!.uid);
      print(user);

      if (user != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: ((context) => BottomNavBar(
             
                    ))));
        
      }

      return user;
    } catch (e) {
      print(e);
    }
  }

  void signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }

  @override
  void initState() {
    TokenProvider tokenProvider =
        Provider.of<TokenProvider>(context, listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TokenProvider tokenProvider = Provider.of<TokenProvider>(
      context,
    );
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SignInButton(Buttons.Google, onPressed: () async {
            final GoogleSignInAccount? googleSignInAccount =
                await googleSignIn.signIn();
            final GoogleSignInAuthentication googleSignInAuthentication =
                await googleSignInAccount!.authentication;
            final AuthCredential credential = GoogleAuthProvider.credential(
                idToken: googleSignInAuthentication.idToken,
                accessToken: googleSignInAuthentication.accessToken);
            final userCredential = await _auth.signInWithCredential(credential);
            final User? user = userCredential.user;
            tokenProvider.settoken('email', user!.email);
             setbooltoken('islogged', user.emailVerified);
                  tokenProvider.setImageToken ('image', user.photoURL);
             tokenProvider.settoken('name', user.displayName);
            signInWithGoogle().then((value) {});
            
          }),
          // ElevatedButton(onPressed: signOut, child: Text('SignOut'))
        ],
      )),
    );
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
 //final GoogleSignIn googleSignIn = GoogleSignIn();


