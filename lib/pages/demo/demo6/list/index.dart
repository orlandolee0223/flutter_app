import 'package:flutter/material.dart';
// components
import 'package:flutter_app/components/refresher/flatList/index.dart';

class ListDemo extends StatefulWidget {
  const ListDemo({super.key});

  @override
  ListDemoState createState() => ListDemoState();
}

class ListDemoState extends FlatList<String, StatefulWidget> {
  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Future<List<String>> getData(
    int pageIndex,
    int pageSize,
    bool forceRefresh,
  ) async {
    return [
      '1', '2', '3', '4', '5', //
      '6', '7', '8', '9', '10' //
    ];
  }

  @override
  Widget renderItem(BuildContext context, int index, String item) {
    return SizedBox(
      height: 50,
      child: Center(child: Text('Item $index')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 100,
          color: Colors.red,
        ),
        Expanded(
          child: renderContent(context),
        ),
      ],
    );
  }
}
