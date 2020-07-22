import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thirdapp/Services.dart';

class Settings extends StatelessWidget {
  final FirebaseUser user;
  var value;
  Settings(this.user);
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection(user.uid)
            .document('Settings')
            .snapshots(),
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.black,
              textTheme: Typography.whiteCupertino,
              hintColor: Colors.white70,
              scaffoldBackgroundColor: Colors.black,
            ),
            home: Scaffold(
              appBar: AppBar(
                title: Text('Settings'),
                leading: BackButton(onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }),
              ),
              body: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 19, top: 8, right: 12),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Sort by',
                          style: TextStyle(fontSize: 18),
                        ),
                        Expanded(child: SizedBox()),
                        DropdownButton(
                          dropdownColor: Colors.grey.shade900,
                          hint: Text(snapshot.data['sort'] == true
                              ? 'Descending'
                              : 'Ascending'),
                          items: [
                            DropdownMenuItem(
                              child: Text('Ascending'),
                              value: 'Ascending',
                            ),
                            DropdownMenuItem(
                              child: Text('Descending'),
                              value: 'Descending',
                            )
                          ],
                          onChanged: (_value) {
                            Services(user: user).updateSort(_value);
                            Provider.of<Services>(context, listen: false)
                                .updateSort2(_value);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
