import 'package:flutter/material.dart';
import '../Authentication/auth.dart';
import '../constants/constant.dart';

class SignIn extends StatefulWidget {
  const SignIn({required this.toggleView});
  final Function toggleView;

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email="";
  String password="",error="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 1.0,
        title: Text('Sign in'),
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
                    },obscureText: true ,validator: (val)=> val!.length < 8?"password must be atleast 8":null),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: ()async{
                  if(_formKey.currentState!.validate()){
                    dynamic result = await _auth.signInWithEmailandPassword(email, password);
                    if(result==null){
                      setState(() {
                        error="sign in failed";
                      });
                    }
                  }}, child: Text('login')),
                SizedBox(height: 12,),
                Text(error),
              ],
            ),
          )
      ),
    );
  }
}
