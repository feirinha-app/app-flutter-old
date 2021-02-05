import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  ListPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GridView.count(
          crossAxisCount: 1,
          children: this._list(),
        ));
  }

  List<Widget> _list() {
    return List.generate(3, (index) => this._listItem(index));
  }

  Widget _listItem(item) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [Checkbox(value: false, onChanged: null), Text(item)],
      ),
    );
  }
}
