import 'package:flutter/material.dart';
import 'package:money_balance/constants/user.dart';

class Credit extends StatefulWidget {
  const Credit({required this.money});
  final List<Money> money;

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  @override
  Widget build(BuildContext context) {
    List<Money> cre=[];
    for(int i=0;i<widget.money.length;i++){
      if(widget.money[i].cat=="credit"){
        cre.add(widget.money[i]);
      }
    }
    if(cre.length!=0){
    return Scaffold(
      appBar: AppBar(title: Text('CREDIT'),),
      body: ListView.separated(itemBuilder: (context,index){
        return Card(
          child: ListTile(
            title: Text("${cre[index].notes}"),
            trailing: Text("${cre[index].money}"),
          ),
        );
      },
          separatorBuilder: (content,index){
        return Container(height: 10,);
          },
          itemCount: cre.length),
    );
  }else{
    return LinearProgressIndicator();
    }
  }
}


class Debit extends StatefulWidget {
  const Debit({required this.money});
  final List<Money> money;

  @override
  State<Debit> createState() => _DebitState();
}

class _DebitState extends State<Debit> {
  @override
  Widget build(BuildContext context) {
    List<Money> deb = [];
    for (int i = 0; i < widget.money.length; i++) {
      if (widget.money[i].cat == "debit") {
        deb.add(widget.money[i]);
      }
    }
    if (deb.length != 0) {
      return Scaffold(
        appBar: AppBar(title: Text('DEBIT'),),
        body: ListView.separated(itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text("${deb[index].notes}"),
              trailing: Text("${deb[index].money}"),
            ),
          );
        },
            separatorBuilder: (content, index) {
              return Container(height: 10,);
            },
            itemCount: deb.length),
      );
    }else{
      return LinearProgressIndicator();
    }
  }
}
