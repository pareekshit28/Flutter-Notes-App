import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

class Services with ChangeNotifier {
  FirebaseUser user;
  Firestore db = Firestore.instance;
  Uuid uuid = Uuid();
  List selectedList = [];
  List idList = [];
  bool sort = true;

  Services({this.user});

  Map<String, dynamic> mapNotes({mapTitle, mapNote, mapId, mapTime, mapColor}) {
    return {
      'title': mapTitle,
      'note': mapNote,
      'id': mapId,
      'time': mapTime,
      'color': mapColor
    };
  }

  Map<String, dynamic> mapSettings({mapSort}) {
    return {
      'sort': mapSort,
    };
  }

  Future add({
    addTitle,
    addNote,
  }) {
    String addId = uuid.v4();
    return db.collection(user.uid).document(addId).setData(mapNotes(
        mapTitle: addTitle,
        mapNote: addNote,
        mapId: addId,
        mapTime: FieldValue.serverTimestamp(),
        mapColor:
            Colors.primaries[Random().nextInt(Colors.primaries.length)].value));
  }

  Future update({updateTitle, updateNote, updateId, updateColor}) {
    return db.collection(user.uid).document(updateId).setData(mapNotes(
        mapTitle: updateTitle,
        mapNote: updateNote,
        mapId: updateId,
        mapTime: FieldValue.serverTimestamp(),
        mapColor: updateColor));
  }

  Future delete(deleteId) {
    return db.collection(user.uid).document(deleteId).delete();
  }

  Future setSort() {
    return db
        .collection(user.uid)
        .document('Settings')
        .setData(mapSettings(mapSort: true));
  }

  Future updateSort(String sort) {
    bool state = sort == 'Descending' ? true : false;
    return db
        .collection(user.uid)
        .document('Settings')
        .setData(mapSettings(mapSort: state));
  }

  void addSelected(int index) {
    selectedList.add(index);
    notifyListeners();
  }

  void addId(String id) {
    idList.add(id);
    notifyListeners();
  }

  void removeSelected(int index) {
    selectedList.remove(index);
    notifyListeners();
  }

  void removeId(String id) {
    idList.remove(id);
  }

  void clearSelected() {
    selectedList.clear();
    notifyListeners();
  }

  void clearId() {
    idList.clear();
    notifyListeners();
  }

  void updateSort2(String value) {
    sort = value == 'Descending' ? true : false;
    notifyListeners();
  }

  void updateSort3(bool value) {
    sort = value;
    notifyListeners();
  }
}
