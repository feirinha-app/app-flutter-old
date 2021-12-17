import 'package:cloud_firestore/cloud_firestore.dart';

class ListItem {}

class CList {
  CList({this.key, this.title, this.items});

  final String key;
  final String title;

  final List<ListItem> items;

  factory CList.fromDocument(DocumentSnapshot snapshot) {
    return CList(key: snapshot.documentID, title: snapshot.data['title']);
  }
}
