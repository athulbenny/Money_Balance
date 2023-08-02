import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_balance/Authentication/databaseService.dart';
import 'package:money_balance/constants/user.dart';



class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  NewUser? _userFromFirebaseUser(User? user) {
    return user != null
        ? NewUser(uid: user.uid, username: user.email ?? "")
        : null;
  }

  Stream<NewUser?> get user {
    return _auth.authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
    //.map(_userFromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      //UserCredential====AuthResult,User====FirebaseUser,onAuthSTateChanges====authStateChanges
      User user = result.user!;
      return _userFromFirebaseUser(user);
    }
    catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  Future registerWithEmailandPassword(String email, String password,String bal) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await MainDatabaseService(username: email).updateUserData(bal);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}