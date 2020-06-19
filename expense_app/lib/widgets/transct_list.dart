import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transact.dart';

class TransctList extends StatelessWidget {
  final List<Transact> transact;
  final Function deleteTx;

  TransctList(this.transact, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transact.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transact added',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (ctx, idx) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('\$${transact[idx].money}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transact[idx].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMM().format(transact[idx].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(transact[idx].id),
                          icon: Icon(Icons.delete_sweep),
                          label: Text('Delete'),
                          color: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete_sweep),
                          color: Theme.of(context).errorColor,
                          onPressed: () => deleteTx(transact[idx].id)),
                ),
              );
            },
            itemCount: transact.length);
  }
}

// Card(
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.symmetric(
//                           vertical: 10,
//                           horizontal: 15,
//                         ),
//                         decoration: BoxDecoration(
//                             border: Border.all(
//                           color: Colors.teal,
//                           width: 2,
//                         )),
//                         padding: EdgeInsets.all(10),
//                         child: Text(
//                           '\$${transact[idx].money.toStringAsFixed(2)}',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20,
//                               color: Theme.of(context).primaryColor),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             transact[idx].title,
//                             style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 15,
//                                 color: Theme.of(context).primaryColor),
//                           ),
//                           Text(
//                             DateFormat('dd/MM/yyyy, mm:HH:ss', 'en_US')
//                                 .format(transact[idx].date),
//                             style: TextStyle(fontSize: 15, color: Colors.grey),
//                           )
//                         ],
//                       ),
//                     ],
//                   ),
//                 );
