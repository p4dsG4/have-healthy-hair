import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p4ds/screens/main_screens/hairline_screens.dart';
import 'package:p4ds/screens/scalp/scalp_1.dart';
import 'package:p4ds/screens/main_screens/home_screen.dart';
import 'package:p4ds/providers/main_provider.dart';
import 'package:p4ds/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:p4ds/screens/main_screen.dart';
import 'package:p4ds/screens/custom_appbar.dart';

class ScalpScreen extends StatelessWidget {
  const ScalpScreen({super.key});


  @override
  Widget build(BuildContext context) {
    final up = Provider.of<UserProvider>(context);
    final mp = Provider.of<MainProvider>(context);
    return  Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(70), // Adjust the height as needed
      //   child: CustomAppBar(
      //     onBackButtonPressed: () {
      //       // Handle back button press if needed
      //     },
      //     onLogoTap: () {
      //       // Handle logo tap here, navigate to the home screen
      //       mp.onChangeMainScreenIndex(0);
      //       Navigator.pop(context); // Use Navigator.pop() to go back to MainScreen
      //
      //     },
      //   ),
      // ),
      body: SafeArea(
          child: Container (
              color: Colors.white,
              child: ListView(children: [
                SizedBox(height: 25),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Check your scalp condition!',
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
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'Upload photos of your scalp.',
                            style: TextStyle(
                              color: Color(0xFF23262F),
                              fontSize: 15,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 0.17,
                            ),
                          )
                      )
                    ]
                ), //Text: Check your scalp condition
                Container(
                    height: 260,
                    child: Column( // image boxes
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset('assets/images/scalp/ex1.png')
                                ),
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset('assets/images/scalp/ex2.png')
                                )
                              ]
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset('assets/images/scalp/ex3.png')
                                ),
                                Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset('assets/images/scalp/ex4.png')
                                )
                              ]
                          )
                        ]
                    )), //두피 부위 사진 4개
                SizedBox(height: 25),
                Padding(
                    padding: EdgeInsets.only(top:10, left: 20),
                    child: Text(
                      'Examples of scalp photo: ',
                      style: TextStyle(
                        color: Color(0xFF23262F),
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        height: 0.17,
                      ),
                    )
                ), //Text: examples of scalp photo
                Container(
                    height: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            width: 100,
                            height: 70,
                            child: Image.asset('assets/images/scalp/ex5.png')
                        ),
                        Container(
                            width: 100,
                            height: 70,
                            child: Image.asset('assets/images/scalp/ex6.png')
                        ),
                        Container(
                            width: 100,
                            height: 70,
                            child: Image.asset('assets/images/scalp/ex7.png')
                        )
                      ],
                    )
                ), //example 사진
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Scalp1Screen() )
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
                      "Upload scalp picture".toUpperCase(),
                      style: TextStyle(fontSize: 16,color :Colors.white), // You can adjust the font size here
                    ),
                  ),
                )



              ])
          )

      ),

    );




  }
}
