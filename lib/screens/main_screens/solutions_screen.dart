import 'package:flutter/material.dart';
import 'package:p4ds/screens/solution/survey_1.dart';

class SolutionsScreen extends StatelessWidget {
  const SolutionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(children: [
          // Row(
          //     children: [
          //       Positioned(
          //         left: 16,
          //         top: 39,
          //         child: Container(
          //           width: 60.62,
          //           height: 77,
          //           child: Stack(
          //             children: [
          //               Positioned(
          //                 left: 46.39,
          //                 top: 0,
          //                 child: Transform(
          //                   transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
          //                   child: Container(
          //                       width: 42.39,
          //                       height: 33.07,
          //                       child: Image.asset('assets/images/home/scalppic.png')
          //
          //                   ),
          //                 ),
          //               ),
          //               Positioned(
          //                 left: 0,
          //                 top: 13.41,
          //                 child: Container(
          //                     width: 60.62,
          //                     height: 63.59,
          //                     child: Image.asset('assets/images/logo.png')
          //
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ), //logo
          //     ]
          // ),
          Container(
          width: 300,
          height: 400,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 17,
                top: 50,
                child: Container(
                  width: 360,
                  height: 400,
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
          SizedBox(height: 10),
          Padding(
              padding: EdgeInsets.all(50),
              child: Text(
                '두피고민을 선택하면 두피 상태를 알아보고 두피 상태에 맞춰 맞춤 솔루션을 추천해요 ',
                style: TextStyle(
                  color: Color(0xFF23262F),
                  fontSize: 12,
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
                "맞춤 솔루션 시작하기".toUpperCase(),
                style: TextStyle(fontSize: 16), // You can adjust the font size here
              ),
            ),
          )



        ]));
  }
}
