
import 'package:cloud_firestore/cloud_firestore.dart';

class MarketList {
  MarketList({this.key, this.title});

  final String key;
  final String title;

  factory MarketList.fromDocument(DocumentSnapshot snapshot) {
    return MarketList(
      key: snapshot.documentID,
      title: snapshot.data['title']
    );
  }
}
