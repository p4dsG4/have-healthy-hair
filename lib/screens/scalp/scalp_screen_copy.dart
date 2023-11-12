import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class ScalpScreen extends StatelessWidget {
  const ScalpScreen({super.key});

  pickImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(children: [
          Row(
            children: [
              Positioned(
                left: 16,
                top: 39,
                child: Container(
                  width: 60.62,
                  height: 77,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 46.39,
                        top: 0,
                        child: Transform(
                          transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
                          child: Container(
                              width: 42.39,
                              height: 33.07,
                              child: Image.asset('assets/images/home/scalppic.png')

                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 13.41,
                        child: Container(
                            width: 60.62,
                            height: 63.59,
                            child: Image.asset('assets/images/logo.png')

                        ),
                      ),
                    ],
                  ),
                ),
              ), //logo
            ]
          ),
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
                padding: EdgeInsets.all(10),
                child: Text(
                  'Upload photos of your scalp.',
                  style: TextStyle(
                    color: Color(0xFF23262F),
                    fontSize: 12,
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
            padding: EdgeInsets.all(10),
            child: Text(
                'Examples of scalp photo: ',
                style: TextStyle(
                  color: Color(0xFF23262F),
                  fontSize: 12,
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
              onPressed: () => pickImage(),
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
                style: TextStyle(fontSize: 16), // You can adjust the font size here
              ),
            ),
          )



        ]));
  }
}
