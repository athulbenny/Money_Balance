import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_balance/constants/user.dart';




class MainDatabaseService{

  final String username;
  MainDatabaseService({required this.username});

  final CollectionReference _usercollection = FirebaseFirestore.instance.collection('main');


  Future updateUserData(String balance)async{
    return await _usercollection.doc(username).set({
      "username":username,
      "balance":balance
    });
  }

  Future updateBalanceData(String balance)async{
    return await _usercollection.doc(username).update({
      "balance":balance
    });
  }

  Stream<List<UsersField>> get balance{
    print('balance is 1');
    return _usercollection.snapshots().map(_balanceListFromDatabase );
  }

  List<UsersField> _balanceListFromDatabase(QuerySnapshot snapshot){
    print('balance is 2');
    return snapshot.docs.map((usersnapshot){
      Map<String,dynamic> _users = jsonDecode(jsonEncode(usersnapshot.data()));
      print("user is" + _users.toString());
      return UsersField(balance: _users["balance"]??"",username: _users["username"]??"");
    }).toList();
  }


  Future updatecreditdebitData(String money,String notes,String cat)async{
    return await _usercollection.doc(username).collection('dcbited').doc().set({
      "cat":cat,
      "money":money,
      "notes":notes
    });
  }

  Stream<List<Money>> get dcbited{
    return _usercollection.doc(username).collection('dcbited').snapshots().map(_moneyListFromDatabase );
  }

  List<Money> _moneyListFromDatabase(QuerySnapshot snapshot){
    return snapshot.docs.map((usersnapshot){
      Map<String,dynamic> _users = jsonDecode(jsonEncode(usersnapshot.data()));
      print("user is" + _users.toString());
      return Money(money: _users["money"]??"",cat: _users["cat"]??"",notes: _users["notes"]??"");
    }).toList();
  }

}
