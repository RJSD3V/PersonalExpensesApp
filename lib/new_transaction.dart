import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addtx;

  NewTransaction(this.addtx);
  NewTransactionState createState() => NewTransactionState();
}

class NewTransactionState extends State<NewTransaction> {
  final title = TextEditingController();
  final amount = TextEditingController();
  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
      lastDate: DateTime.now(),).then((pickedDate){
        if (pickedDate == null){
          return;
        }
        else{
          setState((){
            _selectedDate = pickedDate;
          });

        }
    });

  }

  void submitData() {
    final titleEntry = title.text;
    final amountEntry =
        amount.text.isEmpty ? double.parse('0.0') : double.parse(amount.text);
    print(amount.text.runtimeType);

    if (titleEntry.isEmpty || amountEntry <= 0 || _selectedDate == null) {
      return;
    }

    widget.addtx(
      titleEntry,
      amountEntry,
      _selectedDate
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                    controller: title,
                    decoration: InputDecoration(labelText: "Title"),
                    autocorrect: true,
                    onSubmitted: (_) => submitData(),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: amount,
                    decoration: InputDecoration(labelText: "Amount"),
                    onSubmitted: (_) => submitData(),
                  ),
                  Container(
                      height: 60,
                      child: Row(children: <Widget>[
                        Text(_selectedDate ==null?'No Date Chosen': DateFormat.yMd().format(_selectedDate)),
                        FlatButton(
                            onPressed: _presentDatePicker,
                            textColor: Theme.of(context).primaryColor,
                            child: Text("Choose Date",
                                style: TextStyle(fontWeight: FontWeight.bold))),
                      ])),
                  RaisedButton(
                    textColor: Colors.white,
                    onPressed: submitData,
                    child: Text("Add Transaction",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    color: Colors.purple,
                  )
                ])));
  }
}
