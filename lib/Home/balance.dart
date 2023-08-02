import 'package:flutter/material.dart';
import 'package:money_balance/Authentication/databaseService.dart';
import 'package:money_balance/constants/user.dart';
import 'package:provider/provider.dart';
import 'credit_debit.dart';



class MoneyBalance extends StatefulWidget {
  const MoneyBalance({required this.user,required this.balance});
  final NewUser user;final String balance;


  @override
  State<MoneyBalance> createState() => _MoneyBalanceState();
}

class _MoneyBalanceState extends State<MoneyBalance> {
  TextEditingController value =new TextEditingController();
  TextEditingController notes =new TextEditingController();



  @override
  Widget build(BuildContext context) {
    print('user is in MoneyBalance');print("bal is in MoneyBwlance"+widget.balance.toString());
    final money = Provider.of<List<Money>?>(context)??[];
    if(money.length!=0) {
      return Scaffold(
        appBar: AppBar(),
        body: Container(
          child: Column(
            children: [
              Container(height: MediaQuery
                  .of(context)
                  .size
                  .height / 15,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 3,
                color: Colors.green,
                child: Row(
                  children: [
                    Text('BALANCE'),
                    SizedBox(width: 20,),
                    Text("${widget.balance}"),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Amount'),
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      child: TextField(controller: value,)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Notes'),
                  Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 2,
                      child: TextFormField(controller: notes,)),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {
                    setState(() async {
                      int bal = int.parse(widget.balance) + int.parse(
                          value.text);
                      await MainDatabaseService(username: widget.user.username)
                          .updatecreditdebitData(value.text, notes.text,
                          'credit');

                      await MainDatabaseService(username: widget.user.username)
                          .updateBalanceData(bal.toString());
                    });
                    value.text = "";
                    notes.text = "";
                  }, child: Text('Credit')),

                  TextButton(onPressed: () {
                    setState(() async {
                      int bal = int.parse(widget.balance) - int.parse(
                          value.text);
                      await MainDatabaseService(username: widget.user.username)
                          .updatecreditdebitData(value.text, notes.text,
                          'debit');

                      await MainDatabaseService(username: widget.user.username)
                          .updateBalanceData(bal.toString());
                    });
                    value.text = "";
                    notes.text = "";
                  }, child: Text('Debit')),

                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(onPressed: () {
                    setState(() async {
                      await Navigator.push(context, MaterialPageRoute(
                          builder: (builder) {
                            return Credit(money: money,);
                          }));
                    });
                  }, child: Text('Credit Details')),


                  TextButton(onPressed: () {
                    setState(() async {
                      await Navigator.push(context, MaterialPageRoute(
                          builder: (builder) {
                            return Debit(money: money,);
                          }));
                    });
                  }, child: Text('Debit Details')),

                ],
              ),
            ],
          ),
        ),
      );
    }else{
      return CircularProgressIndicator();
    }
  }
}