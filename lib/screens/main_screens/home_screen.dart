import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:p4ds/screens/main_screens/scalp_screen.dart';
import 'package:p4ds/screens/custom_appbar.dart';
import 'package:p4ds/screens/Products/clinic_list.dart';
import 'package:p4ds/screens/Products/product_list.dart';
import 'package:p4ds/providers/main_provider.dart';
import 'package:p4ds/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:p4ds/screens/main_screen.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Future<String?> getDbdata() async {
  //   FirebaseFirestore db = FirebaseFirestore.instance;
  //   await db.collection("clinic").get().then((event) {
  //     for (var doc in event.docs) {
  //       print("${doc.id} => ${doc.data()}");
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    const text = "Text";
    final up = Provider.of<UserProvider>(context);
    final mp = Provider.of<MainProvider>(context);


    // firebase storage에 넣기!
    FirebaseStorage _storage = FirebaseStorage.instance;
    Reference _ref = _storage.ref("test/text");
    _ref.putString("Hello World !!");

    // FireBaseStorage.getData()
    //     .then((data) => {
    //   for (var i in data.prefixes)<void>{
    //     print(i)
    //   }
    // });




    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(70), // Adjust the height as needed
      //   child: CustomAppBar(
      //     onBackButtonPressed: () {
      //       // Handle back button press if needed
      //     },
      //     onLogoTap: () {
      //       // Handle logo tap here, navigate to the home screen
      //       mp.onChangeMainScreenIndex(0);
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => MainScreen()),
      //       );
      //     },
      //   ),
      // ),
      body: Container(
          width: 400,
          height: 812,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 17,
                top: 40,
                child: Container(
                  width: 360,
                  height: 280,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Material(
                        elevation: 5, // Adjust the elevation value to control the shadow intensity
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: double.infinity,
                          height: 220,
                          decoration: BoxDecoration(
                            color: Color(0xFFF6F6F6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 30, // Adjust the left position as needed
                top: 70, // Adjust the top position as needed
                child: Container(
                  width: 160,
                  height: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      mp.mainPageController.jumpToPage(1);
                      // getDbdata();
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
                              "Scalp Analysis".toUpperCase(),
                              style: TextStyle(fontSize: 18, color: Colors.black87,),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom:5), // Adjust the padding as needed
                          child: Icon(
                            Icons.analytics_rounded,
                            size: 50,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),


              ), //Scalp
              Positioned(
                left: 205, // Adjust the left position as needed
                top: 70, // Adjust the top position as needed
                child: Container(
                  width: 160,
                  height: 160,
                  child: ElevatedButton(
                    onPressed: () {
                      mp.mainPageController.jumpToPage(3);
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
                              "Hairline Analysis".toUpperCase(),
                              style: TextStyle(fontSize: 18, color: Colors.black87,),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom:5), // Adjust the padding as needed
                          child: Icon(
                            Icons.face_retouching_natural,
                            size: 50,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ), //Hairline
              Positioned(
                left: 17,
                top: 280,
                child: Container(
                  width: 400,
                  height: 350,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 10,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ClinicScreen()), // Replace with the desired screen
                            );
                          },
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
                                  width: 360,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Material(
                                        elevation: 5, // Adjust the elevation value to control the shadow intensity
                                        borderRadius: BorderRadius.circular(12),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                                          child: Image.asset('assets/images/home/hospital.png'),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10, // Adjust the top position as needed
                                        left: 10, // Adjust the left position as needed
                                        child: Text(
                                          'Nearby Hospital'.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white, // Text color
                                            fontSize: 16,        // Text size
                                            fontWeight: FontWeight.bold, // Text style
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 180,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ProductScreen()), // Replace with the desired screen
                            );
                          },
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
                                  width: 360,
                                  height: 200,
                                  child: Stack(
                                    children: [
                                      Material(
                                        elevation: 5, // Adjust the elevation value to control the shadow intensity
                                        borderRadius: BorderRadius.circular(12),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                                          child: Image.asset('assets/images/home/shampoo.png'),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10, // Adjust the top position as needed
                                        left: 10, // Adjust the left position as needed
                                        child: Text(
                                          'Scalp care products'.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.white, // Text color
                                            fontSize: 16,        // Text size
                                            fontWeight: FontWeight.bold, // Text style
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ), //탈모병원&샴푸두피케어
            ],
          ),
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


