import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenPage extends StatefulWidget {
  const TokenPage({super.key});

  @override
  State<TokenPage> createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  String? token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('$token'),
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();

                var tokenId = pref.getString('token');
                setState(() {
                  print(tokenId);

                  token = tokenId!;
                });
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
    );
  }
}
