import 'package:flutter/material.dart';
import 'package:listacompras/pages/list.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _items = ['Lista 1', 'Lista  2'];

  void _incrementCounter() {
    setState(() {
      _items.add('Lista ${_items.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(this._items.length, (index) {
              final item = this._items[index];

              return InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => ListPage(
                                title: item,
                              )));
                },
                child: Center(
                  child: Text(item),
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
