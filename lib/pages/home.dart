import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:listacompras/models/market_list.dart';
import 'package:listacompras/pages/list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MarketList> marketList = [];

  void _incrementCounter() {
    setState(() {
      this
          .marketList
          .add(MarketList(key: 'Lista ${this.marketList.length + 1}'));
    });
  }

  @override
  Widget build(BuildContext context) {
    final _user_id = '12345';

    CollectionReference reference = Firestore.instance.collection('lists');

    return FutureBuilder<List<QuerySnapshot>>(
      future: Future.wait([
        reference.where('owner', isEqualTo: _user_id).getDocuments(),
        reference
            .where('collaborators', arrayContains: _user_id)
            .getDocuments(),
      ]),
      builder:
          (BuildContext context, AsyncSnapshot<List<QuerySnapshot>> snapshots) {
        if (snapshots.hasError) {
          return Text("Something went wrong");
        }

        if (snapshots.connectionState == ConnectionState.done) {
          List<DocumentSnapshot> lists = List.from(snapshots.data[0].documents)
            ..addAll(snapshots.data[1].documents);

          this.marketList = lists
              .map((snapshot) => MarketList.fromDocument(snapshot))
              .toList();

          return this.home();
        }

        return Text("Loading");
      },
    );

    // reference.where('owner', isEqualTo: _user_id).snapshots(),
    // reference.where('collaborators', arrayContains: _user_id).snapshots()

    // return StreamBuilder<QuerySnapshot>(
    //   stream: StreamGroup.merge([
    //     reference.where('owner', isEqualTo: _user_id).snapshots(),
    //     reference.where('collaborators', arrayContains: _user_id).snapshots(),
    //   ]),
    //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
    //     if (snapshots.hasError) {
    //       return Text("Something went wrong");
    //     }

    //     // snapshots.data.toList().then((value) => print(value));

    //     if (snapshots.connectionState == ConnectionState.waiting) {
    //       return Text("loading");
    //     }

    //     print(snapshots.data.documents);

    //     // print(snapshots.data.documents);

    //     snapshots.data.documents.forEach((e) {
    //       print(e.data);
    //     });

    //     return Text("Full Name");
    //   },
    // );
  }

  Scaffold home() {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(this.marketList.length, (index) {
              final item = this.marketList[index];

              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ListPage(
                                marketList: item,
                              )));
                },
                child: Center(
                  child: Text(item.title),
                ),
              );
            })),
        floatingActionButton: FloatingActionButton(
          onPressed: _incrementCounter,
          tooltip: 'Adicionar',
          child: Icon(Icons.add),
        ));
  }
}
