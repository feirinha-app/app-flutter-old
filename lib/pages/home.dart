import 'package:flutter/material.dart';
import 'package:lists/models/list.dart';
import 'package:lists/pages/list.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CList> marketList = [];

  void _incrementCounter() {
    setState(() {
      this.marketList.add(CList(key: 'Lista ${this.marketList.length + 1}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user_id = '12345';

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference reference = firestore.collection('lists');

    return FutureBuilder<DocumentSnapshot>(
      // future: Future.wait([
      //   reference.where('owner', isEqualTo: _user_id).get(),
      //   reference.where('collaborators', arrayContains: _user_id).get(),
      // ]),
      // future: reference.where('owner', isEqualTo: _user_id),
      future: reference.doc(_user_id).get(),
      builder:
          // (BuildContext context, AsyncSnapshot<List<QuerySnapshot>> snapshots) {
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data.data() as Map<String, dynamic>;

          return Text("Title: ${data['title']}");
        }

        return Text("loading");

        // if (snapshots.hasError) {
        //   return Text("Something went wrong");
        // }

        // if (snapshots.connectionState == ConnectionState.done) {
        //   List<DocumentSnapshot> lists = List.from(snapshots.data[0].documents)
        //     ..addAll(snapshots.data[1].documents);

        //   this.marketList =
        //       lists.map((snapshot) => CList.fromDocument(snapshot)).toList();

        //   return this.home();
        // }

        // return Text("Loading");
      },
    );
  }

  Scaffold home() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          this.marketList.length,
          (index) {
            final item = this.marketList[index];

            return InkWell(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => ListPage(
                      marketList: item,
                    ),
                  ),
                );
              },
              child: Center(
                child: Text(item.title),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Adicionar',
        child: Icon(Icons.add),
      ),
    );
  }
}
