import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:thirdapp/AuthScreen.dart';
import 'package:thirdapp/GridList.dart';
import 'package:thirdapp/Services.dart';

void main() => runApp(ChangeNotifierProvider<Services>(
      create: (context) => Services(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          textTheme: Typography.whiteCupertino,
          hintColor: Colors.white70,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: GateKeeper(),
      ),
    ));

enum SignedState { signedIn, notSignedIn }

class GateKeeper extends StatefulWidget {
  @override
  _GateKeeperState createState() => _GateKeeperState();
}

class _GateKeeperState extends State<GateKeeper> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  FirebaseUser user;
  SignedState signedState;
  @override
  void initState() {
    super.initState();
    checkIfUserIsSignedIn();
    currentUser();
  }

  void checkIfUserIsSignedIn() async {
    var userSignedIn = await _googleSignIn.isSignedIn();

    setState(() {
      signedState =
          userSignedIn ? SignedState.signedIn : SignedState.notSignedIn;
    });
  }

  void currentUser() async {
    var currentUser = await _auth.currentUser();
    setState(() {
      user = currentUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (signedState == SignedState.signedIn) {
      print('inside first if');
      if (user.uid != null) {
        print('inside second if');
        return GridList(
          user: user,
          auth: _auth,
          googleSignIn: _googleSignIn,
        );
      } else {
        print('inside else');
        return Center(child: CircularProgressIndicator());
      }
    } else {
      return Authentication();
    }
  }
}
