import 'package:flutter/material.dart';
import 'package:p4ds/providers/main_provider.dart';
import 'package:p4ds/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../Hairline/hairline_upload.dart';
import 'package:p4ds/screens/scalp/scalp_1.dart';


class HairlineScreen extends StatelessWidget {
  const HairlineScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFEEEEEE),
      child:SafeArea(
          child: ListView(children: [
            Container(
              width: 300,
              height: 430,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
              child: Stack(
                children: [
                  Positioned(
                    left: 17,
                    top: 50,
                    child: Container(
                      width: 360,
                      height: 450,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              height: 430,
                              child: Image.asset('assets/images/home/hairline.jpg')
                          ),
                        ],
                      ),
                    ),
                  ), //grey box

                ],
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.only(left:50, top:50, bottom:50, right:20),
              child: Text(
                'Analyze and Predict Your Hairline!',
                style: TextStyle(
                  color: Color(0xFF23262F),
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                softWrap: true, // Enable text wrapping
              ),
            ), //Text: examples of scalp photo
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HairlineUploadScreen())
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
                  "Analyze".toUpperCase(),
                  style: TextStyle(fontSize: 16,color :Colors.white), // You can adjust the font size here
                ),
              ),
            )



          ])),
    );

  }
}
