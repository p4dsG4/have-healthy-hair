import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p4ds/screens/main_screens/solutions_screen.dart';


class SolutionResultScreen extends StatelessWidget {
  const SolutionResultScreen(this.productKey, {super.key});

  final String productKey;

  pickImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery);
  }

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
                      SizedBox(height: 0),
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            '당신의 두피고민에 딱 맞춘 상품',
                            style: TextStyle(
                              color: Color(0xFF23262F),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              height: 0.17,
                            ),
                          )
                      )
                    ]
                ),
                SizedBox(height: 30),//Text: Check your scalp condition
                Positioned(
                  left: 17,
                  top: 280,
                  child: Container(
                    width: 400,
                    height: 300,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 20,
                          top: 10,
                          child: Container(
                            width: 400,
                            height: 350,
                            padding: const EdgeInsets.only(bottom: 42),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 350,
                                  height: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Your onPressed logic here
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      minimumSize: MaterialStateProperty.all(Size(160, 160)), // Adjust the width and height as needed
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the background color
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 12.0), // Adjust the top and left padding as needed
                                            child: Text(
                                              "product1".toUpperCase(),
                                              style: TextStyle(fontSize: 18, color: Colors.black87,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 20,
                          top: 120,
                          child: Container(
                            width: 400,
                            height: 350,
                            padding: const EdgeInsets.only(bottom: 42),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 350,
                                  height: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Your onPressed logic here
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      minimumSize: MaterialStateProperty.all(Size(160, 160)), // Adjust the width and height as needed
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the background color
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 12.0), // Adjust the top and left padding as needed
                                            child: Text(
                                              "product2".toUpperCase(),
                                              style: TextStyle(fontSize: 18, color: Colors.black87,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ), //탈모병원&샴푸두피케어
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 0),
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            '정밀 진단이 필요하다면...',
                            style: TextStyle(
                              color: Color(0xFF23262F),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              height: 0.17,
                            ),
                          )
                      )
                    ]
                ),
                SizedBox(height: 30),//Text: Check your scalp condition
                Positioned(
                  left: 17,
                  top: 280,
                  child: Container(
                    width: 400,
                    height: 300,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 20,
                          top: 10,
                          child: Container(
                            width: 400,
                            height: 350,
                            padding: const EdgeInsets.only(bottom: 42),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 350,
                                  height: 100,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // Your onPressed logic here
                                    },
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.white),
                                        ),
                                      ),
                                      minimumSize: MaterialStateProperty.all(Size(160, 160)), // Adjust the width and height as needed
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the background color
                                    ),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 12.0), // Adjust the top and left padding as needed
                                            child: Text(
                                              "clinic1".toUpperCase(),
                                              style: TextStyle(fontSize: 18, color: Colors.black87,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ), //탈모병원&샴푸두피케어
              ])
          ),
        ),


    );
  }
}
