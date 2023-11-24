import 'package:flutter/material.dart';
import 'package:p4ds/screens/Profile/scalp_records.dart';
import 'package:p4ds/screens/Profile/Wishlist.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top:16.0), // Adjust the padding as needed
          child: Text(
            "my page",
            style: TextStyle(
              color: Colors.black, // Set the desired text color
            ),
          ),
        ),
        toolbarHeight: 70, // default is 56
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(top: 16.0), // Adjust the padding as needed
          child: IconButton(
            icon: Icon(Icons.close, color: Colors.black54),
            onPressed: () {
              // Navigate back when the back arrow is tapped
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
            width: 375,
            height: 812,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(color: Colors.white),
            child: Stack(
              children: [
                Positioned(
                  left: 25,
                  top: 50,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey, // Set the background color of the container
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person, // Replace with the desired icon
                        size: 40, // Adjust the size of the icon as needed
                        color: Colors.black87, // Set the color of the icon
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 112,
                  top: 80,
                  child: Text(
                    'Welcome, Sunyoung',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                      letterSpacing: -0.24,
                    ),
                  ),
                ), //welcome
                Positioned(
                  left: 25,
                  top: 180,
                  child: ElevatedButton(
                    onPressed: () {
                      // You can add your logic when the button is tapped
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Make the button transparent
                      elevation: 0, // Remove shadow
                    ),
                    child: Container(
                      width: 327,
                      height: 24,
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit, // Replace with the desired icon
                            color: Color(0xBF091C3F), // Icon color
                            size: 25, // Adjust the size of the icon as needed
                          ),
                          SizedBox(width: 10), // Add some space between the icon and text
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: Color(0xBF091C3F), // Text color
                              fontSize: 18,
                              fontFamily: 'Overpass',
                              fontWeight: FontWeight.bold,
                              height: 0.00,
                              letterSpacing: -0.24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ), //edit profile
                Positioned(
                  left: 25,
                  top: 240,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScalpRecordsScreen()),
                      );
                      // You can add your logic when the button is tapped
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          return Colors.transparent; // Make the button transparent
                        },
                      ),
                      elevation: MaterialStateProperty.all<double>(0), // Remove shadow
                      overlayColor: MaterialStateProperty.all<Color>(
                        Colors.transparent, // Set the overlay color to transparent
                      ),
                    ),
                    child: Container(
                      width: 327,
                      height: 24,
                      child: Row(
                        children: [
                          Icon(
                            Icons.insert_drive_file, // Replace with the desired icon
                            color: Color(0xBF091C3F), // Icon color
                            size: 27, // Adjust the size of the icon as needed
                          ),
                          SizedBox(width: 10), // Add some space between the icon and text
                          Text(
                            'My reports',
                            style: TextStyle(
                              color: Color(0xBF091C3F), // Text color
                              fontSize: 18,
                              fontFamily: 'Overpass',
                              fontWeight: FontWeight.bold,
                              height: 0,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 25,
                  top: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const WishlistScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.transparent, // Make the button transparent
                      elevation: 0, // Remove shadow
                    ),
                    child: Container(
                      width: 327,
                      height: 24,
                      child: Row(
                        children: [
                          Icon(
                            Icons.favorite, // Replace with the desired icon
                            color: Color(0xBF091C3F), // Icon color
                            size: 27, // Adjust the size of the icon as needed
                          ),
                          SizedBox(width: 10), // Add some space between the icon and text
                          Text(
                            'Wishlist',
                            style: TextStyle(
                              color: Color(0xBF091C3F), // Text color
                              fontSize: 18,
                              fontFamily: 'Overpass',
                              fontWeight: FontWeight.bold,
                              height: 0,
                              letterSpacing: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ), //wish list
                //edit profile
              ],
            ),
          ),
        ),


    );
  }
}
