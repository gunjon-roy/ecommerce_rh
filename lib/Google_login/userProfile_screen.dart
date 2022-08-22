
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../providers/tokenstoreprovider.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class UserInfoScreen extends StatefulWidget {
  // UserInfoScreen({Key? key, required User user, })
  //     : _user = user,
    
  //       super(key: key);

  // final User _user;
  // bool islogged = false;

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  // late User _user;
  // bool _isSigningOut = false;
  void signOut() async {
    await googleSignIn.signOut();
    await _auth.signOut();
  }

  bool? isloging;
  @override
  void initState() {
   TokenProvider tokenProvider=Provider.of(context,listen: false);
    // print(widget.islogged);
    // _user = widget._user;
//print(tokenProvider.token);
tokenProvider.gettoken();

print(  'Email ${tokenProvider.useremail}');
print(  'name ${tokenProvider.usernam}');
    super.initState();
   // gettoken();
  }
// gettoken()async{
//       TokenProvider tokenProvider=Provider.of(context,listen: false);
//       final data=await tokenProvider.gettoken();
//  return data;
// }
  @override
  Widget build(BuildContext context) {
      TokenProvider tokenProvider=Provider.of(context,);
      tokenProvider.useremail;
      tokenProvider.usernam;
    return Scaffold(
    appBar: AppBar(title: Text('Profile'),centerTitle: true,elevation: 0,backgroundColor: Colors.grey,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            bottom: 20.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(),
           tokenProvider. islogged ==true
                  ? ClipOval(
                      child: Material(
                        child: Image.network(
                       tokenProvider.image!,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    )
                  : ClipOval(
                      child: Material(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Icon(
                            Icons.person,
                            size: 60,
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 16.0),
         tokenProvider.islogged == false
                  ? Text(
                      'Hello',
                      style: TextStyle(
                        fontSize: 26,
                      ),
                    )
                  : Container(),
              SizedBox(height: 8.0),
              Text(
                tokenProvider.usernam!,
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                ' ${tokenProvider.useremail!} ',
                style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 24.0),
              Text(
                'You are now signed in using your Google account. To sign out of your account, click the "Sign Out" button below.',
                style: TextStyle(fontSize: 14, letterSpacing: 0.2),
              ),
              SizedBox(height: 16.0),
            ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.redAccent,
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      onPressed: () async {
                        // setState(() {
                        //   _isSigningOut = true;
                        // });
                    // tokenProvider.remove();
                        signOut();
                        tokenProvider.islogged=false;
                        // setState(() {
                        //   _isSigningOut = false;
                        // });
                        print(tokenProvider.islogged);
                       // Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => BottomNavBar())));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          'Sign Out',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
