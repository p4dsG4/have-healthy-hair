import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:p4ds/screens/main_screens/scalp_screen.dart';


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
            left: 45, // Adjust the left position as needed
            top: 100, // Adjust the top position as needed
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScalpScreen() )
                );// Handle the tap gesture here
              },
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
                      child: Image.asset('assets/images/home/scalppic.png'),
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
            ),
          ),
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


