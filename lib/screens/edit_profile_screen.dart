// import 'package:p4ds/screens/profile_setting_screen.dart';
import 'package:flutter/material.dart';

class EditScreenProfile extends StatelessWidget {
  const EditScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person_off_outlined),
            onPressed: () {
              // You can navigate to the profile settings page or open a dialog
              // For example, using Navigator.push:
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => ProfileSettingsPage()),
              // );
            },
          ),
        ],
      ),
      // The rest of your Scaffold body goes here
    );
  }
}
