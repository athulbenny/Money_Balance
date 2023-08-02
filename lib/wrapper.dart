import 'package:flutter/material.dart';
import 'package:money_balance/Home/balance.dart';
import 'package:money_balance/Authentication/databaseService.dart';
import 'package:money_balance/constants/user.dart';
import 'package:provider/provider.dart';

import 'login/authenticate.dart';


class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUser?>(context);
    if(user == null){
      print('user is null');
      return Authenticate();
    }else{
      print('user is not null');
      return Home(user: user);
    }
  }
}

class Home extends StatefulWidget {
  const Home({required this.user});
  final NewUser user;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    print('user is in home');
    return StreamProvider.value(value: MainDatabaseService(username: widget.user.username).balance,
        initialData: null,
        child: Linker(user:widget.user),
    );
  }
}


class Linker extends StatefulWidget {
  const Linker({required this.user});
  final NewUser user;

  @override
  State<Linker> createState() => _LinkerState();
}

class _LinkerState extends State<Linker> {
  @override
  Widget build(BuildContext context) {
    print('user is in linker');
    final balances = Provider.of<List<UsersField>?>(context)??[];
    print("balances length="+balances.length.toString());
    String bal="";
    if(balances.length!=0){
    for(int i=0;i<balances.length;i++) {
      if(balances[i].username==widget.user.username){
        bal=balances[i].balance;print("bal is "+bal);
    }}
      return StreamProvider.value(
        value: MainDatabaseService(username: widget.user.username).dcbited,
        initialData: null,
        child: MoneyBalance(user: widget.user, balance: bal),
      );
    }else{
       return CircularProgressIndicator();
    }
  }
}
