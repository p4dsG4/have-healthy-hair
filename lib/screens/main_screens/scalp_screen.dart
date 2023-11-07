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
              Container(
                  width: 375,
                  height: 44,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 78,
                        top: -2,
                        child: Container(
                          width: 219,
                          height: 30,
                          child: Stack(children: [

                          ]),
                        ),
                      ),
                      Positioned(
                        left: 293.67,
                        top: 17.33,
                        child: Container(
                          width: 66.66,
                          height: 11.34,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 42.33,
                                top: 0,
                                child: Container(
                                  width: 24.33,
                                  height: 11.33,
                                  child: Stack(children: [

                                  ]),
                                ),
                              ),
                              Positioned(
                                left: 22.03,
                                top: 0,
                                child: Container(
                                  width: 15.27,
                                  height: 10.97,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("https://via.placeholder.com/15x11"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0.34,
                                child: Container(
                                  width: 17,
                                  height: 10.67,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage("https://via.placeholder.com/17x11"),
                                      fit: BoxFit.fill,
                                    ),
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
              Container(
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
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage("https://via.placeholder.com/42x33"),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 13.41,
                        child: Container(
                          width: 60.62,
                          height: 63.59,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage("https://via.placeholder.com/61x64"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              Container(
                  width: 79,
                  height: 37,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 79,
                          height: 37,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 0.10, color: Color(0xFF706B6E)),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x21000000),
                                blurRadius: 5,
                                offset: Offset(2, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 15,
                        top: 13,
                        child: Container(
                          width: 15,
                          height: 10,
                          child: Stack(children: [

                          ]),
                        ),
                      ),
                      Positioned(
                        left: 44,
                        top: 6,
                        child: Container(
                          width: 23,
                          height: 23,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ]
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '나의 두피 상태는?',
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
          ),
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
          )),
          SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
                'Examples of scalp photo',
                style: TextStyle(
                  color: Color(0xFF23262F),
                  fontSize: 12,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 0.17,
                ),
              )
          ),
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
          ),
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
                "두피 사진 업로드".toUpperCase(),
                style: TextStyle(fontSize: 16), // You can adjust the font size here
              ),
            ),
          )



        ]));
  }
}
