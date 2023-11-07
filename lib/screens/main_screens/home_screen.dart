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
          Positioned(
            left: 0,
            top: 0,
            child: Container(
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
          ),
          Positioned(
            left: 17,
            top: 143,
            child: Container(
              width: 343,
              height: 212,
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
          ),
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
          ),
          Positioned(
            left: 47,
            top: 421,
            child: Container(
              width: 289,
              height: 323,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 110,
                      height: 177,
                      padding: const EdgeInsets.only(bottom: 42),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF6F6F6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: Text(
                              '우리동네 탈모병원',
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
                    left: 179,
                    top: 0,
                    child: Container(
                      width: 110,
                      height: 177,
                      padding: const EdgeInsets.only(bottom: 42),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF6F6F6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: Text(
                              '샴푸 & 두피케어',
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
                    left: 179,
                    top: 146,
                    child: Container(
                      width: 110,
                      height: 177,
                      padding: const EdgeInsets.only(bottom: 42),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF6F6F6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: Text(
                              '모발이식',
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
                      width: 110,
                      height: 177,
                      padding: const EdgeInsets.only(bottom: 42),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 110,
                            height: 110,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF6F6F6),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          SizedBox(
                            width: 110,
                            child: Text(
                              '헤어라인 & 문신',
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
          ),
          Positioned(
            left: 277,
            top: 75,
            child: Container(
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
          ),
          Positioned(
            left: -1,
            top: 729,
            child: Container(
              width: 379,
              height: 83.50,
              child: Stack(
                children: [
                  Positioned(
                    left: 1,
                    top: 0,
                    child: Container(
                      width: 375,
                      height: 83.50,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 375,
                              height: 83.50,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 375,
                                    height: 83,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 375,
                                            height: 83,
                                            decoration: BoxDecoration(color: Color(0xFFFAFAFA)),
                                          ),
                                        ),
                                        Positioned(
                                          left: 120,
                                          top: 69,
                                          child: Container(
                                            width: 134,
                                            height: 5,
                                            decoration: ShapeDecoration(
                                              color: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(100),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 375,
                                    height: 0.50,
                                    decoration: BoxDecoration(color: Color(0xFFBDC5CD)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 27,
                            top: 4,
                            child: Container(
                              width: 54,
                              height: 47,
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 129,
                            top: 14,
                            child: Container(
                              width: 32,
                              height: 31,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage("https://via.placeholder.com/32x31"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 53,
                    child: SizedBox(
                      width: 110,
                      height: 11,
                      child: Text(
                        'Home',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF585858),
                          fontSize: 9,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 90,
                    top: 53,
                    child: SizedBox(
                      width: 110,
                      height: 11,
                      child: Text(
                        'Scalp',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF585858),
                          fontSize: 9,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 178,
                    top: 53,
                    child: SizedBox(
                      width: 110,
                      height: 11,
                      child: Text(
                        'Solutions',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF585858),
                          fontSize: 9,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 269,
                    top: 53,
                    child: SizedBox(
                      width: 110,
                      height: 11,
                      child: Text(
                        'Hairline',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF585858),
                          fontSize: 9,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 62,
            top: 197,
            child: Container(
              width: 110,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: ShapeDecoration(
                      color: Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '두피분석',
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
          ),
          Positioned(
            left: 226,
            top: 197,
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
                    decoration: ShapeDecoration(
                      color: Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '헤어라인',
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
          ),
          Positioned(
            left: 62,
            top: 197,
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
                    decoration: ShapeDecoration(
                      color: Color(0xFFD9D9D9),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '두피분석',
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
          ),
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


