import 'package:flutter/material.dart';
import '../Authentication/auth.dart';
import '../constants/constant.dart';


class Register extends StatefulWidget {
  const Register({required this.toggleView});
  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formKey = GlobalKey<FormState>();

  String email="",password="",error="",bal="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 1.0,
        title: Text('Sign up'),
        actions: [
          IconButton(onPressed: (){
            widget.toggleView();
          }, icon: Icon(Icons.person))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  onChanged: (val){
                    setState(() {
                      email=val;
                    });
                  },validator: (val)=> val!.isEmpty?"email cannot be empty":null,),
                SizedBox(height: 20,),
                TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    onChanged: (val){
                      setState(() {
                        password=val;
                      });
                    }, obscureText: true ,
                    validator: (val)=> val!.length < 8?"password must be atleast 8":null),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Balance'),
                  onChanged: (val){
                    setState(() {
                      bal=val;
                    });
                  },validator: (val)=> val!.isEmpty?"police id cannot be empty":null,),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: ()async{
                  dynamic result;
                  if(_formKey.currentState!.validate()){
                    result = _auth.registerWithEmailandPassword(email,password,bal);
                    if(result==null){
                      setState(() {
                        error="register failed";
                      });
                    }
                  }
                }, child: Text('register')),
                SizedBox(height: 12,),
                Text(error),
              ],
            ),
          )
      ),
    );
  }
}
