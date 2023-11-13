import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    const text = "Text";

    // FireBaseStorage.getData()
    //     .then((data) => {
    //       for (var i in data.prefixes)<void>{
    //         print(i)
    //       }
    // });

    //firebase storage에 넣기!
    FirebaseStorage _storage = FirebaseStorage.instance;
    Reference _ref = _storage.ref("test/text");
    _ref.putString("Hello World !!");


    return Container(
      width: 375,
      height: 812,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: Colors.white),
      child: Stack(
        children: [
          // Positioned(
          //   left: 16,
          //   top: 39,
          //   child: Container(
          //     width: 60.62,
          //     height: 77,
          //     child: Stack(
          //       children: [
          //         Positioned(
          //           left: 46.39,
          //           top: 0,
          //           child: Transform(
          //             transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(3.14),
          //             child: Container(
          //                 width: 42.39,
          //                 height: 33.07,
          //                 child: Image.asset('assets/images/home/scalppic.png')
          //
          //             ),
          //           ),
          //         ),
          //         Positioned(
          //           left: 0,
          //           top: 13.41,
          //           child: Container(
          //               width: 60.62,
          //               height: 63.59,
          //               child: Image.asset('assets/images/logo.png')
          //
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ), //logo
          // Positioned(
          //   left: 277,
          //   top: 75,
          //   child: Container(
          //     width: 79,
          //     height: 37,
          //     child: Stack(
          //       children: [
          //         Positioned(
          //           left: 0,
          //           top: 0,
          //           child: Container(
          //             width: 79,
          //             height: 37,
          //             decoration: ShapeDecoration(
          //               color: Colors.white,
          //               shape: RoundedRectangleBorder(
          //                 side: BorderSide(width: 0.10, color: Color(0xFF706B6E)),
          //                 borderRadius: BorderRadius.circular(30),
          //               ),
          //               shadows: [
          //                 BoxShadow(
          //                   color: Color(0x21000000),
          //                   blurRadius: 5,
          //                   offset: Offset(2, 4),
          //                   spreadRadius: 0,
          //                 )
          //               ],
          //             ),
          //           ),
          //         ),
          //         Positioned(
          //           left: 15,
          //           top: 13,
          //           child: Container(
          //             width: 15,
          //             height: 10,
          //             child: Stack(children: [
          //
          //             ]),
          //           ),
          //         ),
          //         Positioned(
          //           left: 44,
          //           top: 6,
          //           child: Container(
          //             width: 23,
          //             height: 23,
          //             clipBehavior: Clip.antiAlias,
          //             decoration: BoxDecoration(),
          //             child: Row(
          //               mainAxisSize: MainAxisSize.min,
          //               mainAxisAlignment: MainAxisAlignment.center,
          //               crossAxisAlignment: CrossAxisAlignment.center,
          //               children: [
          //
          //               ],
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ), //오른쪽 맨위
          Positioned(
            left: 17,
            top: 50,
            child: Container(
              width: 343,
              height: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 240,
                    decoration: ShapeDecoration(
                      color: Color(0xFFF6F6F6),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
          ), //grey box
          Positioned(
            left: 62,
            top: 100,
            child: Container(
              width: 110,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 110,
                      height: 110,
                      child: Image.asset('assets/images/home/scalppic.png')
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Scalp Analysis',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ), //두피분석
          Positioned(
            left: 226,
            top: 100,
            child: Container(
              width: 110,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Color(0xFFF6F6F6)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      width: 110,
                      height: 110,
                      child: Image.asset('assets/images/home/forehead.png')
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Hairline Analysis',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
          ), //헤어라인
          Positioned(
            left: 47,
            top: 330,
            child: Container(
              width: 289,
              height: 323,
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 0,
                    child: Container(
                      width: 400,
                      height: 200,
                      padding: const EdgeInsets.only(bottom: 42),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 280,
                              height: 110,
                              child: Image.asset('assets/images/home/hospital.png')

                          ),
                          SizedBox(
                            width: 280,
                            child: Text(
                              'Nearby hospitals',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 146,
                    child: Container(
                      width: 400,
                      height: 200,
                      padding: const EdgeInsets.only(bottom: 42),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              width: 300,
                              height: 110,
                              child: Image.asset('assets/images/home/shampoo.png')

                          ),
                          SizedBox(
                            width: 300,
                            child: Text(
                              'Scalp care product',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
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
        ],
      ),
    );
  }
}

// class FireBaseStorage {
//   static Future<ListResult> getData() async {
//     final storageRef = FirebaseStorage.instance.ref();
//     return storageRef.listAll();
//   }
// }