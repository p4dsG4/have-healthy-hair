import 'package:flutter/material.dart';
import 'package:p4ds/screens/solution/survey_1.dart';

class SolutionsScreen extends StatelessWidget {
  const SolutionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xFFEEEEEE),
        child:SafeArea(
          child: ListView(children: [
            Container(
              width: 340,
              height: 420,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Color(0xFFEEEEEE)),
              child: Stack(
                children: [
                  Positioned(
                    left: 17,
                    top: 50,
                    child: Container(
                      width: 360,
                      height: 420,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: double.infinity,
                              height: 400,
                              child: Image.asset('assets/images/home/solution.png')
                          ),
                        ],
                      ),
                    ),
                  ), //grey box

                ],
              ),
            ),
            SizedBox(height: 3),
            Padding(
              padding: EdgeInsets.only(left:60, right:50, top:50, bottom:40),
              child: Text(
                'Find Solutions tailored to your Scalp Condition!',
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
                      MaterialPageRoute(builder: (context) => const Survey1Screen())
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
                  "Start".toUpperCase(),
                  style: TextStyle(fontSize: 16,color :Colors.white), // You can adjust the font size here
                ),
              ),
            )



          ])),
    );
  }
}
