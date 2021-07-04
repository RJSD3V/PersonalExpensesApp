import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';

class TransactionList extends StatelessWidget {
  final _transaction_list;
  final Function deleteTxn;
  TransactionList(this._transaction_list, this.deleteTxn);

  Widget build(BuildContext context) {
    return this._transaction_list.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(children: <Widget>[
              Text(
                'No Transactions added yet',
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/wait.png',
                    fit: BoxFit.cover,
                  ))
            ]);
          })
        : Container(
            height: 500,
            child: ListView.builder(
                itemCount: _transaction_list.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 6,
                      child: Padding(
                          padding: EdgeInsets.all(5),
                          child: ListTile(
                            subtitle: Text(
                              DateFormat()
                                  .format(_transaction_list[index].date),
                              style: TextStyle(color: Colors.grey),
                            ),
                            leading: CircleAvatar(
                                radius: 35,
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: FittedBox(
                                        child: Text(
                                            "\$${_transaction_list[index].amount}",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ))))),
                            title: Text(_transaction_list[index].title,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor,
                              onPressed: () =>
                                  deleteTxn(_transaction_list[index].id),
                            ),
                          )));
                }),
          );
  }
}
