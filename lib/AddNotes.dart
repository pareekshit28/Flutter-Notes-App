import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:thirdapp/Services.dart';

enum Type { add, edit }

class AddNotes extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final notesFocus = FocusNode();
  final Type type;
  final title;
  final note;
  final String i;
  final int color;
  final FirebaseUser user;

  AddNotes({this.i, this.type, this.title, this.note, this.color, this.user}) {
    titleController.text = title;
    noteController.text = note;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: Text(
              type == Type.add ? 'Add Notes' : 'Edit',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: Colors.white,
            )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (type == Type.add) {
              if (titleController.text != '' || noteController.text != '') {
                Services(user: user).add(
                    addTitle: titleController.text,
                    addNote: noteController.text);
              }
              Navigator.pop(context);
            } else {
              if (titleController.text != '' || noteController.text != '') {
                Services(user: user).update(
                    updateTitle: titleController.text,
                    updateNote: noteController.text,
                    updateId: i,
                    updateColor: color);
              }
              Navigator.pop(context);
            }
          },
          splashColor: Colors.green,
          label: Text(
            type == Type.add ? 'Add' : 'Save',
            style: TextStyle(color: Colors.black),
          ),
          icon: Icon(
            type == Type.add ? Icons.add : Icons.save,
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        hintText: 'Title',
                        hintStyle: TextStyle(color: Colors.white70),
                        border: InputBorder.none),
                    style: TextStyle(fontSize: 20, color: Colors.white),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(notesFocus)),
                TextField(
                  controller: noteController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Note',
                    hintStyle: TextStyle(color: Colors.white70),
                    border: InputBorder.none,
                  ),
                  style: TextStyle(color: Colors.white),
                  maxLines: null,
                  focusNode: notesFocus,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
