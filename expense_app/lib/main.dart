import 'package:flutter/material.dart';

import './widgets/transct_list.dart';
import './widgets/transct_new.dart';
import './widgets/chart.dart';
import './models/transact.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter APP',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.brown,
          accentColor: Colors.amber,
          textTheme: ThemeData.light().textTheme.copyWith(
                button: TextStyle(
                  color: Colors.white,
                ),
              )),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInp;
  // String amountInp;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transact> _usrTransct = [];
  bool _showChart = false;
  List<Transact> get _recentTransct {
    return _usrTransct.where(
      (tx) {
        return tx.date.isAfter(
          DateTime.now().subtract(
            Duration(days: 7),
          ),
        );
      },
    ).toList();
  }

  void _addNewTransct(String title, double amount, DateTime chooseDate) {
    final newAmg = Transact(
        id: DateTime.now().toString(),
        title: title,
        money: amount,
        date: chooseDate);

    setState(() {
      _usrTransct.add(newAmg);
    });
  }

  void _deleteTransct(String id) {
    setState(() {
      _usrTransct.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  void _startTansct(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (bCtx) {
        return GestureDetector(
          onTap: () {},
          behavior: HitTestBehavior.opaque,
          child: TransctNew(_addNewTransct),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLand = mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      title: Text('Expense APP'),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            onPressed: () => _startTansct(context))
      ],
    );

    final txListWid = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransctList(_usrTransct, _deleteTransct),
    );

    return Scaffold(
      appBar: appBar,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLand)
            Row(
              children: <Widget>[
                Text('Show chart'),
                Switch(
                  value: _showChart,
                  onChanged: (val) {
                    setState(() {
                      _showChart = val;
                    });
                  },
                ),
              ],
            ),
          if (!isLand)
            Container(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.3,
              child: Chart(_recentTransct),
            ),
            if(!isLand) txListWid,
           if(isLand) _showChart
              ? Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.3,
                  child: Chart(_recentTransct),
                )
              : txListWid,
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startTansct(context),
      ),
    );
  }
}
