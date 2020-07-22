import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:thirdapp/GridList.dart';

class Authentication extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.1),
                BlendMode.dstATop,
              ),
              image: AssetImage('assets/images/logo.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(26.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                Text(
                  'Log in',
                  style: TextStyle(
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    letterSpacing: 1,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'To',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    letterSpacing: 1,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'Continue..',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    letterSpacing: 1,
                    fontStyle: FontStyle.normal,
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            onPressed: () {
                              onGoogleSignIn(context);
                            },
                            color: Colors.white,
                            splashColor: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/google_logo.png',
                                    scale: 20,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                  Text(
                                    'Sign in with Google',
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Made with ❤ in India',
                        style: TextStyle(color: Colors.white),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);

    user = (await _auth.signInWithCredential(credential)).user;

    return user;
  }

  void onGoogleSignIn(BuildContext context) async {
    FirebaseUser user = await signInWithGoogle();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GridList(
                  user: user,
                  googleSignIn: _googleSignIn,
                  auth: _auth,
                )));
  }
}
