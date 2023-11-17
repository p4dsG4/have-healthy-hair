import 'package:flutter/material.dart';
import 'package:p4ds/screens/Profile/scalp_records.dart';



class ScalpResultScreen extends StatelessWidget {
  const ScalpResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70, // default is 56
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(top: 16.0), // Adjust the padding as needed
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () {
              // Navigate back when the back arrow is tapped
              Navigator.of(context).popUntil((route)=>route.isFirst);
            },
          ),
        ),
      ),
      body: SafeArea(
          child: Container(
              color: Colors.white,
              child: ListView(children: [
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                      // SizedBox(height: 10),
                      Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            '현재 나의 두피 상태는',
                            style: TextStyle(
                              color: Color(0xFF23262F),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                            ),
                          )
                      )
                    ]
                ),
                SizedBox(height: 20),
                Positioned(
                  left: 100,
                  top: 100,
                  child: Container(
                    width: 100,
                    height: 250,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 25, // Adjust the left position of the image
                          top: 0, // Adjust the top position of the image
                          child: Image.asset(
                            'assets/images/home/head.png', // Your image
                            width: 300, // Set the desired width of the image
                            height: 250, // Set the desired height of the image
                          ),
                        ),
                        Positioned(
                          left: 70, // Adjust the left position of the box
                          top: 70, // Adjust the top position of the box
                          child: Container(
                            width: 70, // Set the width of the box
                            height: 70, // Set the height of the box
                            color: Colors.red.withOpacity(0.5), // Set the color of the box
                          ),
                        ),
                        Positioned(
                          left: 220, // Adjust the left position of the box
                          top: 70, // Adjust the top position of the box
                          child: Container(
                            width: 70, // Set the width of the box
                            height: 70, // Set the height of the box
                            color: Colors.lightGreen.withOpacity(0.5), // Set the color of the box
                          ),
                        ),
                        Positioned(
                          left: 145, // Adjust the left position of the box
                          top: 0, // Adjust the top position of the box
                          child: Container(
                            width: 70, // Set the width of the box
                            height: 70, // Set the height of the box
                            color: Colors.yellow.withOpacity(0.5), // Set the color of the box
                          ),
                        ),
                        Positioned(
                          left: 145, // Adjust the left position of the box
                          top: 100, // Adjust the top position of the box
                          child: Container(
                            width: 70, // Set the width of the box
                            height: 70, // Set the height of the box
                            color: Colors.orange.withOpacity(0.5), // Set the color of the box
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                          padding: EdgeInsets.only(top:15,left:35,bottom: 15),
                          child: Text(
                            '미세각질 ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                            ),
                          )
                      )
                    ]
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                          padding: EdgeInsets.only(top:15,left:35,bottom: 15),
                          child: Text(
                            '피지과다 ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                            ),
                          )
                      )
                    ]
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                          padding: EdgeInsets.only(top:15,left:35,bottom: 15),
                          child: Text(
                            '모낭사이홍반 ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                            ),
                          )
                      )
                    ]
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                          padding: EdgeInsets.only(top:15,left:35,bottom: 15),
                          child: Text(
                            '모낭홍반/농포 ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                            ),
                          )
                      )
                    ]
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                          padding: EdgeInsets.only(top:15,left:35,bottom: 15),
                          child: Text(
                            '비듬 ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                            ),
                          )
                      )
                    ]
                ),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Padding(
                          padding: EdgeInsets.only(top:15,left:35,bottom: 15),
                          child: Text(
                            '탈모 ',
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.7),
                              fontSize: 12,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                            ),
                          )
                      )
                    ]
                ),
                SizedBox(height: 10),

                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ScalpRecordsScreen() )
                      );
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.green),
                        ),
                      ),
                      minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color to light green
                    ),
                    child: Text(
                      "나의 두피 기록".toUpperCase(),
                      style: TextStyle(fontSize: 16), // You can adjust the font size here
                    ),
                  ),
                ),



              ])
          ),
        ),


    );
  }
}
