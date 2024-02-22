import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_list_contact/view/pages/home_page.dart';
import 'package:get_list_contact/view/pages/share_location.dart';
import 'package:get_list_contact/view/pages/token_page.dart';
import 'package:get_list_contact/view/pages/use_camera.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.contact_phone),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Get Data Contact')
                ],
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserCameraPage(),
                    ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Get Data Storage')
                ],
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShareLocationPage(),
                    ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Share Location')
                ],
              )),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TokenPage(),
                    ));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.key),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Show Token')
                ],
              )),
        ],
      ),
    ));
  }
}
