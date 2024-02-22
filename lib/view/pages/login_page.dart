import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_list_contact/view/pages/main_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  ValueNotifier userCredential = ValueNotifier('');

  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      _isLoggedIn = user != null;
    });
  }

  Future<dynamic> signInWithGoogle() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      print('ini credent ${credential}');

      pref.setString('token', credential.accessToken!);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on Exception catch (e) {
      print('exception->$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ElevatedButton(
              onPressed: () async {
                await signInWithGoogle();
              },
              child: Text('Sign In with Google')),
        )
      ],
    ));
  }
}
