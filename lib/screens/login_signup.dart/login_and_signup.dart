
import 'package:ecommerce_rah/providers/login_signup.dart';
import 'package:ecommerce_rah/screens/bottomnav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../../Google_login/userProfile_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // var isselected = true;
  var isvisible = true;
  var _isvisible = true;
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

      //CHECKING IS ON
      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);

      final User? currentUser = await _auth.currentUser;
      assert(currentUser!.uid == user!.uid);
      print(user);

      if (user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => BottomNavBar())));
      }

      return user;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignupLogicModel>(
      builder: (context, change, child) => Scaffold(
        appBar: AppBar(
          title: change.isselected
              ? Text('SignUp Page',
                  style: TextStyle(
                      fontFamily: 'rrr', fontSize: 18, color: Colors.black))
              : Text('Login Page',
                  style: TextStyle(
                      fontFamily: 'rrr', fontSize: 18, color: Colors.black)),
          elevation: 0,
          backgroundColor: change.isselected ? Colors.grey : Colors.grey[300],
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
              child: Column(
            children: [
              Card(
                shape: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                elevation: 10,
                shadowColor: Colors.white,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              child: TextButton(
                                  onPressed: () {
                                    change.checkcolor2();
                                  },
                                  child: Text('SignUP',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'rrr',
                                          color: change.isselected
                                              ? Colors.black
                                              : Colors.black
                                                  .withOpacity(0.2))))),
                          Container(
                              child: TextButton(
                                  onPressed: () {
                                    change.checkcolor();
                                  },
                                  child: Text('Login',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'rrr',
                                          color: change.isselected
                                              ? Colors.black.withOpacity(0.2)
                                              : Colors.black))))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Form(
                        key: formKey,
                        child: Column(children: [
                          change.isselected
                              ? SingUp(
                                  // controller: userController,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Please Enter Your Name';
                                  //   } else if (value.length <= 2) {
                                  //     return 'minimam 3 character';
                                  //   } else if (!RegExp(r'^[a-z A-Z]+$')
                                  //       .hasMatch(value)) {
                                  //     return 'Invilid EXpression';
                                  //   }
                                  //   return null;
                                  // },
                                  showtex: false,
                                  confirm: false,
                                  obsecuretext: false,
                                  obsecurecharecter: 'a',
                                  hintext: 'Enter Your Name',
                                  label: 'Name',
                                  icon: Icons.person)
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          SingUp(
                              // controller: emailController,
                              // validator: (value) {
                              //   if (value!.isEmpty) {
                              //     return 'Please Enter Your Email';
                              //   } else if (!RegExp(r'^[\w\.]+@')
                              //       .hasMatch(value)) {
                              //     return ' Invalid Email1';
                              //   } else if (!RegExp(r'^[\w\.]+@([\g])')
                              //       .hasMatch(value)) {
                              //     return '"Invalid Email"';
                              //   } else if (!RegExp(r'^[\w\.]+@([\w]+\.)')
                              //       .hasMatch(value)) {
                              //     return '"."  Is Not In Proper Place';
                              //   } else if (!RegExp(
                              //           r'^[\w\.]+@([\w]+\.)+[\w]{2,4}')
                              //       .hasMatch(value)) {
                              //     return 'Atlest character 2 after " . "';
                              //   }
                              //   return null;
                              // },
                              showtex: false,
                              confirm: false,
                              obsecuretext: false,
                              obsecurecharecter: 'a',
                              hintext: 'Enter Your Email',
                              label: 'Email',
                              icon: Icons.email),
                          SizedBox(
                            height: 10,
                          ),
                          change.isselected
                              ? SingUp(
                                  // controller: mobileController,
                                  // validator: (value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'Please enter Phone Number';
                                  //   } else if (!RegExp(
                                  //           r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$')
                                  //       .hasMatch(value)) {
                                  //     return ' Invalid Mobile Number';
                                  //   } else if (value.length <= 10) {
                                  //     return 'Must Enter 11 Dgits';
                                  //   }
                                  //   return null;
                                  // },
                                  showtex: false,
                                  confirm: false,
                                  obsecuretext: false,
                                  obsecurecharecter: 1.toString(),
                                  hintext: 'Enter Your Mobile Number',
                                  label: 'Mobile Number',
                                  icon: Icons.phone)
                              : Container(),
                          SizedBox(
                            height: 10,
                          ),
                          SingUp(
                              controller: change.isselected
                                  ? passwordController
                                  : loginpasswordController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please Enter Password';
                                }

                                //UpperCase,lowerCase,numerical Symbol,Number
                                else if (!RegExp(
                                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                    .hasMatch(value)) {
                                  return ' Must be upper & lower case & symbol & number';
                                } else if (value.length <= 7) {
                                  return 'Must Enter 8 Dgits';
                                }
                                return null;
                              },
                              obsecuretext: isvisible,
                              showtex: true,
                              confirm: false,
                              obsecurecharecter: '*',
                              hintext: 'Enter Your Password',
                              label: 'Password',
                              icon: Icons.lock),
                          SizedBox(
                            height: 10,
                          ),
                          change.isselected
                              ? SingUp(
                                  controller: confirmPasswordController,
                                  validator: (val) {
                                    if (val!.isEmpty) return 'Empty';
                                    if (val != passwordController.text)
                                      return 'Not Match';
                                    return null;
                                  },
                                  showtex: false,
                                  confirm: true,
                                  obsecuretext: _isvisible,
                                  obsecurecharecter: '*',
                                  hintext: 'Confirm Your Password',
                                  label: ' Confirm Password',
                                  icon: Icons.lock)
                              : Container(),
                          Container(
                              child: Column(
                            children: [
                              // change.isselected
                              //     ? Container()
                              //     : checkbox(
                              //         text: 'Remember Me',
                              //       ),
                              Container(
                                padding: EdgeInsets.only(left: 150),
                                child: change.isselected
                                    ? Container()
                                    : Text(
                                        'Forgot Password ?',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 16,
                                            fontFamily: 'rrr'),
                                      ),
                              ),
                              Text(
                                'Or signup using',
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 15,
                                    fontFamily: 'rrr'),
                              ),
                              SizedBox(
                                height: 16,
                              ),

                              SignInButton(Buttons.Google, onPressed: () {
                           signInWithGoogle();
                              }),
                              SizedBox(height: 10),

                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Icon(
                              //       Icons.facebook,
                              //       size: 50,
                              //       color: Colors.blue,
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     CircleAvatar(
                              //       backgroundImage: NetworkImage(
                              //           'https://blog.hubspot.com/hubfs/image8-2.jpg'),
                              //     ),
                              //     SizedBox(
                              //       width: 10,
                              //     ),
                              //     CircleAvatar(
                              //       backgroundImage: NetworkImage(
                              //           'https://image.shutterstock.com/image-photo/kiev-ukraine-may-08-2015-260nw-281364161.jpg'),
                              //     ),
                              //   ],
                              // ),
                              Divider(
                                indent: 10,
                                endIndent: 10,
                                height: 10,
                              )
                            ],
                          ))
                        ]),
                      )
                    ],
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {},
                child: Container(
                  // height: 45,
                  padding: EdgeInsets.all(10),
                  width: 400,
                  decoration: BoxDecoration(
                      color: change.isselected ? Colors.grey : Colors.grey[300],
                      borderRadius: BorderRadius.circular(35)),

                  child: GestureDetector(
                      onTap: () {
                        // if (formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   const SnackBar(content: Text('Processing Data')

                          //   ),
                          // );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => BottomNavBar())));
                        // }
                        //  else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(content: Text('Processing Data')),
                        //   );
                        // }
                      },
                      child: change.isselected
                          ? Center(
                              child: Text(
                              'SignUp',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'rrr',
                              ),
                            ))
                          : Center(
                              child: Text(
                                'Login',
                                style:
                                    TextStyle(fontSize: 18, fontFamily: 'rrr'),
                              ),
                            )),
                ),
              ),
            ],
          )),
        ),
      ),
    );
  }

  SingUp(
      {hintext,
      label,
      icon,
      obsecuretext,
      confirm = true,
      obsecurecharecter,
      validator,
      showtex,
      controller}) {
    return Container(
      height: 50,
      child: TextFormField(
        controller: controller,
        obscureText: obsecuretext,
        obscuringCharacter: obsecurecharecter,
        validator: validator,
        decoration: InputDecoration(
          //  border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          hintText: hintext,
          hintStyle: TextStyle(fontSize: 12),
          //  label: Text(label),
          prefixIcon: Icon(icon),
          suffixIcon: showtex
              ? InkWell(
                  onTap: password,
                  child:
                      Icon(isvisible ? Icons.visibility : Icons.visibility_off))
              : confirm
                  ? InkWell(
                      onTap: compassword,
                      child: Icon(
                          _isvisible ? Icons.visibility : Icons.visibility_off))
                  : null,
        ),
      ),
    );
  }

  void password() {
    setState(() {
      isvisible = !isvisible;
    });
  }

  void compassword() {
    setState(() {
      _isvisible = !_isvisible;
    });
  }
}

final FirebaseAuth _auth = FirebaseAuth.instance;
//final GoogleSignIn googleSignIn = GoogleSignIn();
