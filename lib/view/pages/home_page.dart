import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact>? contactsList;

  void getPhoneData() async {
    if (await FlutterContacts.requestPermission()) {
      contactsList = await FlutterContacts.getContacts(
          withProperties: true, withPhoto: true);
    }
    setState(() {});
  }

  @override
  void initState() {
    getPhoneData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: contactsList == null
          ? Center()
          : ListView.builder(
              itemCount: contactsList!.length,
              itemBuilder: (context, index) {
                Uint8List? image = contactsList![index].photo;
                String num = (contactsList![index].phones.isNotEmpty)
                    ? (contactsList![index].phones.first.number)
                    : "--";

                return GestureDetector(
                  onTap: () {
                    if (contactsList![index].phones.isNotEmpty) {
                      launchUrlString('tel: ${num}');
                    }
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 1,
                              offset: Offset(2, 2),
                              color: Colors.grey.shade300)
                        ]),
                    child: Row(
                      children: [
                        (contactsList![index].photo == null)
                            ? const CircleAvatar(child: Icon(Icons.person))
                            : CircleAvatar(
                                backgroundImage: MemoryImage(image!)),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              contactsList![index].displayName,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            Text(num),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
    );
  }
}
