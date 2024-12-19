import 'package:firebase_auth/firebase_auth.dart';

Future<bool> signup(String emailAddress, String password) async {
    try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      print("Sign up in progress...");
      // print(credentials);
      return true;
    } catch (e) {
      print("-----------Error-----------------");
      print(e);
      return false;
    }
  }

  Future<bool> signin(String emailAddress, String password) async {
    try {
      final credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      print("Signed in successfully: ${credentials.user?.email}");
      
      return true;
    } on FirebaseAuthException catch (e) {
      // Firebase-specific errors
      print("-----------Error-----------------");
      print("Error Code: ${e.code}");
      print("Error Message: ${e.message}");
      return false;
    } catch (e) {
      // General errors
      print("-----------Unexpected Error-----------------");
      print(e.toString());
      return false;
    }
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }