import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:p4ds/models/user.dart';

import 'package:firebase_storage/firebase_storage.dart';

import '../../repo/user_repository.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserProfileState();
}

class _UserProfileState extends State<EditProfileScreen> {
  final UserRepository _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),

      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFEEEEEE),
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height:50),
          Positioned(
            left: 25,
            top: 50,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey, // Set the background color of the container
              ),
              child: Center(
                child: Icon(
                  Icons.person, // Replace with the desired icon
                  size: 100, // Adjust the size of the icon as needed
                  color: Colors.black87, // Set the color of the icon
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _userRepository.getStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData)
                  return CircularProgressIndicator(
                    strokeWidth: 12.0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  );
                print(snapshot.data!.docs.first);
                return _buildUserView(context, snapshot.data!.docs.first);
              },
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildUserView(BuildContext context, DocumentSnapshot data) {
  final Users user = Users.fromSnapshot(data);
  return Center(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
      children: [
        SizedBox(height:40),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top:20), // Add padding as needed
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "User ID: ${user.userID}" ?? "No Data",
              style: TextStyle(
                fontSize: 20,
                  fontWeight: FontWeight.w500// Adjust the font size as needed
// Adjust the font size as needed
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top:20), // Add padding as needed
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Name: ${user.userName}" ?? "No Data",
              style: TextStyle(
                fontSize: 20,
                  fontWeight: FontWeight.w500// Adjust the font size as needed
// Adjust the font size as needed
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top:20), // Add padding as needed
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Sex: ${user.sex}" ?? "No Data",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500// Adjust the font size as needed
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top:20), // Add padding as needed
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Birth: ${user.birth}" ?? "No Data",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500// Adjust the font size as needed
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top:20), // Add padding as needed
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Address: ${user.zipCode
              }" ?? "No Data",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500// Adjust the font size as needed
              ),
            ),
          ),
        ),

        // Add more Text widgets for other user properties if needed
      ],
    ),
  );
}