import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:thirdapp/AddNotes.dart';
import 'package:thirdapp/AuthScreen.dart';
import 'package:thirdapp/Services.dart';
import 'package:thirdapp/Settings.dart';

class GridList extends StatefulWidget {
  final GoogleSignIn googleSignIn;
  final FirebaseUser user;
  final FirebaseAuth auth;

  GridList({this.user, this.googleSignIn, this.auth});

  @override
  _GridListState createState() => _GridListState();
}

class _GridListState extends State<GridList> {
  bool state;
  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light));
    return Consumer<Services>(
        builder: (BuildContext context, Services services, Widget child) {
      return StreamBuilder(
          stream: Firestore.instance
              .collection(widget.user.uid)
              .orderBy('time', descending: services.sort)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ));

            return Consumer<Services>(
                builder: (BuildContext context, services, Widget child) {
              return Builder(
                builder: (context) => Scaffold(
                  drawer: Drawer(
                    child: SafeArea(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black87,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                        radius: 25,
                                        backgroundImage:
                                            NetworkImage(widget.user.photoUrl)),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          widget.user.displayName,
                                          overflow: TextOverflow.fade,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          'Signed In',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 0, right: 16, top: 8, bottom: 8),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Expanded(child: SizedBox()),
                                        InkWell(
                                          onTap: () => Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (context) =>
                                                      Settings(widget.user))),
                                          child: Row(
                                            children: <Widget>[
                                              SizedBox(
                                                width: 12,
                                              ),
                                              Icon(
                                                Icons.settings,
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                width: 11,
                                              ),
                                              Text(
                                                'Settings',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  backgroundColor: Colors.black,
                  appBar: AppBar(
                    title: Text('Notes'),
                    backgroundColor: Colors.black,
                    actions: <Widget>[
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black87,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          Row(
                                            children: <Widget>[
                                              CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      widget.user.photoUrl)),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    widget.user.displayName,
                                                    overflow: TextOverflow.fade,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    'Signed In',
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: <Widget>[
                                                Expanded(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: InkWell(
                                                      onTap: () {
                                                        widget.auth
                                                            .signOut()
                                                            .then((value) =>
                                                                widget
                                                                    .googleSignIn
                                                                    .signOut())
                                                            .then((value) => Navigator.pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Authentication()),
                                                                ((Route route) =>
                                                                    false)));
                                                      },
                                                      child: Text(
                                                        'Sign Out',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .redAccent),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(widget.user.photoUrl),
                              radius: 13,
                            ),
                          ),
                          SizedBox(width: 12),
                        ],
                      )
                    ],
                  ),
                  floatingActionButton: services.selectedList.length == 0
                      ? FloatingActionButton(
                          elevation: 8,
                          child: Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          backgroundColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddNotes(
                                          type: Type.add,
                                          user: widget.user,
                                        )));
                          })
                      : FloatingActionButton(
                          elevation: 8,
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                          onPressed: () {
                            for (String id in services.idList) {
                              Services(user: widget.user).delete(id);
                            }
                            Provider.of<Services>(context, listen: false)
                                .clearSelected();
                            Provider.of<Services>(context, listen: false)
                                .clearId();
                          }),
                  body: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Consumer<Services>(builder:
                        (BuildContext context, services, Widget child) {
                      return ListView.separated(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, index) => InkWell(
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        if (snapshot.data.documents[index]
                                                ['title'] !=
                                            '')
                                          Text(
                                              snapshot.data.documents[index]
                                                  ['title'],
                                              style: TextStyle(
                                                fontSize: snapshot
                                                                .data.documents[
                                                            index]['note'] !=
                                                        ''
                                                    ? 24
                                                    : 18,
                                                fontWeight: snapshot
                                                                .data.documents[
                                                            index]['note'] !=
                                                        ''
                                                    ? FontWeight.bold
                                                    : FontWeight.normal,
                                                color: Colors.white,
                                              )),
                                        if (snapshot.data.documents[index]
                                                    ['title'] !=
                                                '' &&
                                            snapshot.data.documents[index]
                                                    ['note'] !=
                                                '')
                                          SizedBox(
                                            height: 3,
                                          ),
                                        if (snapshot.data.documents[index]
                                                ['note'] !=
                                            '')
                                          Text(
                                            snapshot.data.documents[index]
                                                ['note'],
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                            maxLines: 8,
                                          ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border: Border.all(
                                      color: Color(snapshot
                                          .data.documents[index]['color']),
                                      width: 1.5,
                                    ),
                                    color: services.selectedList.contains(index)
                                        ? Colors.blue.withOpacity(0.5)
                                        : Colors.transparent,
                                  ),
                                ),
                                onTap: () {
                                  if (services.selectedList.length == 0) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => AddNotes(
                                          title: snapshot.data.documents[index]
                                              ['title'],
                                          note: snapshot.data.documents[index]
                                              ['note'],
                                          i: snapshot.data.documents[index]
                                              ['id'],
                                          type: Type.edit,
                                          color: snapshot.data.documents[index]
                                              ['color'],
                                          user: widget.user,
                                        ),
                                      ),
                                    );
                                  } else {
                                    if (services.selectedList.contains(index)) {
                                      Provider.of<Services>(context,
                                              listen: false)
                                          .removeSelected(index);
                                      Provider.of<Services>(context,
                                              listen: false)
                                          .removeId(snapshot
                                              .data.documents[index]['id']);
                                    } else {
                                      Provider.of<Services>(context,
                                              listen: false)
                                          .addSelected(index);
                                      Provider.of<Services>(context,
                                              listen: false)
                                          .addId(snapshot.data.documents[index]
                                              ['id']);
                                    }
                                  }
                                },
                                onLongPress: () {
                                  Provider.of<Services>(context, listen: false)
                                      .addSelected(index);
                                  Provider.of<Services>(context, listen: false)
                                      .addId(
                                          snapshot.data.documents[index]['id']);
                                },
                              ),
                          separatorBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 12,
                            );
                          });
                    }),
                  ),
                ),
              );
            });
          });
    });
  }

  void check() async {
    DocumentSnapshot ds = await Firestore.instance
        .collection(widget.user.uid)
        .document('Settings')
        .get();
    if (!ds.exists) {
      Services(user: widget.user).setSort();
    } else {
      await Firestore.instance
          .collection(widget.user.uid)
          .document('Settings')
          .get()
          .then((value) {
        Provider.of<Services>(context, listen: false)
            .updateSort3(value['sort']);
      });
    }
  }
}
