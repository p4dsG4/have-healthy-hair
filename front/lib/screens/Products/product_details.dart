import 'package:flutter/material.dart';
import 'package:p4ds/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart'; // Import the Flutter material package
import 'package:intl/intl.dart'; // Import intl package
import 'package:cloud_firestore/cloud_firestore.dart';


class ProductDetailScreen extends StatefulWidget {
  final Products product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isInWishlist = false;

  @override
  void initState() {
    super.initState();
    checkIfInWishlist();
  }

  void checkIfInWishlist() async {
    FirebaseFirestore.instance
        .collection('wishlist')
        .where('productId', isEqualTo: widget.product.id) // Corrected field name
        .get()
        .then((querySnapshot) {
      setState(() {
        isInWishlist = querySnapshot.docs.isNotEmpty;
      });
    });
  }

  void toggleWishlist() async {
    final productId = widget.product.id; // Assuming product has an id
    final wishlistCollection = FirebaseFirestore.instance.collection('wishlist');

    if (isInWishlist) {
      // Logic to remove the product from the wishlist
      wishlistCollection
          .where('productId', isEqualTo: productId)
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          doc.reference.delete();
        });
      }).catchError((error) {
        print('Error removing from wishlist: $error');
      });
    } else {
      // Logic to add the product to the wishlist
      wishlistCollection
          .add({
        'productId': productId,
        // Add other product details if necessary
      }).catchError((error) {
        print('Error adding to wishlist: $error');
      });
    }

    setState(() {
      isInWishlist = !isInWishlist;
    });
  }


  Future<String?> getImageUrl(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      final downloadUrl = await ref.getDownloadURL();
      // print(imagePath);
      return downloadUrl;
    } catch (e) {
      print('Error getting image URL: $e');
      print(imagePath);
      return null;
    }
  }

  String? _formatDate(dynamic date) {
    if (date == null) return null;

    DateTime dateTime;
    if (date is Timestamp) {  // If the date is a Firestore Timestamp
      dateTime = date.toDate();
    } else if (date is DateTime) {  // If the date is already a DateTime object
      dateTime = date;
    } else {
      return null; // Return null if the date is not in a recognized format
    }

    return DateFormat('yyyy-MM-dd').format(dateTime); // Format the date
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20, top: 20),
            child: IconButton(
              icon: Icon(
                isInWishlist ? Icons.favorite : Icons.favorite_border,
                size: 40,
                color: isInWishlist ? Colors.pink : Colors.black54,
              ),
              onPressed: toggleWishlist,
            ),
          ),
        ],
    toolbarHeight: 70, // default is 56
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFEEEEEE),
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(top: 16.0), // Adjust the padding as needed
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () {
              // Navigate back when the back arrow is tapped
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
            color: Color(0xFFEEEEEE),
            child: ListView(children: [
              SizedBox(height: 20),
              Positioned(
                left: 0,
                top: 143,
                child: Container(
                  width: 343,
                  height: 550,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 500,
                        child: FutureBuilder<String?>(
                          future: getImageUrl(widget.product.imagePath.toString()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error loading image');
                            } else if (snapshot.hasData && snapshot.data != null) {
                              return Image.network(
                                snapshot.data!,
                                width: double.infinity,
                                height: 400,
                                fit: BoxFit.cover,
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),


                      ),
                    ],
                  ),
                ),
              ), //이미지
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(left:20),
                        child: Text(
                          widget.product.name.toString() ?? "Unknown",
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height:1.5,
                          ),
                        )
                    ),
                  ]
              ),
              Container(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 30.0), // Adjust the padding as needed
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 90,
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Color(0xFFF6F6F6)),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
                          ),
                          child: Text(
                            "#민감성".toUpperCase(),
                            style: TextStyle(fontSize: 10, color: Colors.white,),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Add space of 10 units between containers
                      Container(
                        width: 90,
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.green),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
                          ),
                          child: Text(
                            "#비듬성".toUpperCase(),
                            style: TextStyle(fontSize: 10, color: Colors.white,),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Add space of 10 units between containers
                      Container(
                        width: 90,
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.green),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
                          ),
                          child: Text(
                            "#건성".toUpperCase(),
                            style: TextStyle(fontSize: 10, color: Colors.white,),
                          ),
                        ),
                      ),
                      Divider( // Add a Divider below the container
                        color: Colors.black, // You can customize the color of the divider
                        thickness: 1.0, // You can adjust the thickness of the divider
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0), // Adjust the padding as needed
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.5), // Color of the border
                        width: 1.0, // Thickness of the border
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          "Ingredients",
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0.17,
                          ),
                        ),
                      ),
                      // Add more content to your Column as needed
                    ],
                  ),
                ),
              ), //Address
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top:10,left:30, right:30),
                        child: Text(
                          widget.product.ingredients.toString(),
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        )
                    )
                  ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star, // Replace with the star icon you want to use
                          color: Colors.yellow,
                          size: 50,
                        ),
                        SizedBox(width: 5), // Add space between the icon and text
                        Text(
                          widget.product.score.toString(),
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            height: 0.10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ), //리뷰스코어
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0),
                    Padding(
                        padding: EdgeInsets.only(top:0,left:85),
                        child: Text(
                          "${widget.product.reviewCnt.toString() ?? "Unknown"} ratings",
                          style: TextStyle(
                            color: Colors.grey.withOpacity((0.8)),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0.2,
                          ),
                        )
                    )
                  ]
              ), //리뷰개수
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star, // Replace with the star icon you want to use
                          color: Colors.yellow,
                          size: 25,
                        ),
                        SizedBox(width: 5), // Add space between the icon and the first text
                        Text(
                          widget.product.review?['SCORE'].toString() ?? "Unknown", // Display comment or "Unknown" if null
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            height: 0.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 20), // Add padding on the right
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                _formatDate(widget.product.review?['DATE']) ?? "Unknown",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                  height: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(top:10,left:35),
                        child: Text(
                          widget.product.review?['USER_ID'] ?? "Unknown", // Display comment or "Unknown" if null
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0.17,
                          ),
                        )
                    )
                  ]
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(top:10,left:35,right: 35),
                        child: Text(
                          widget.product.review?['RW_DTLC'] ?? "Unknown", // Display comment or "Unknown" if null
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                        )
                    )
                  ]
              ),
            ])
        ),
      ),
    );
  }
}


//
// class ProductDetailScreen extends StatelessWidget {
//   final Products product;
//   const ProductDetailScreen({super.key, required this.product});
//
//   Future<String?> getImageUrl(String imagePath) async {
//     try {
//       final ref = FirebaseStorage.instance.ref().child(imagePath);
//       final downloadUrl = await ref.getDownloadURL();
//       // print(imagePath);
//       return downloadUrl;
//     } catch (e) {
//       print('Error getting image URL: $e');
//       print(imagePath);
//       return null;
//     }
//   }
//
//   String? _formatDate(dynamic date) {
//     if (date == null) return null;
//
//     DateTime dateTime;
//     if (date is Timestamp) {  // If the date is a Firestore Timestamp
//       dateTime = date.toDate();
//     } else if (date is DateTime) {  // If the date is already a DateTime object
//       dateTime = date;
//     } else {
//       return null; // Return null if the date is not in a recognized format
//     }
//
//     return DateFormat('yyyy-MM-dd').format(dateTime); // Format the date
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Padding(
//             padding: EdgeInsets.only(right: 20,top:20),
//             child: IconButton(
//               icon: const Icon(Icons.favorite_outline, size: 40, color: Colors.black54),
//               onPressed: () {
//               },
//             ),
//           ),
//         ],
//         toolbarHeight: 70, // default is 56
//         automaticallyImplyLeading: false,
//         backgroundColor: Colors.white,
//         shadowColor: Colors.transparent,
//         leading: Padding(
//           padding: EdgeInsets.only(top: 16.0), // Adjust the padding as needed
//           child: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.black54),
//             onPressed: () {
//               // Navigate back when the back arrow is tapped
//               Navigator.pop(context);
//             },
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//             color: Colors.white,
//             child: ListView(children: [
//               SizedBox(height: 20),
//               Positioned(
//                 left: 0,
//                 top: 143,
//                 child: Container(
//                   width: 343,
//                   height: 550,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                           width: double.infinity,
//                           height: 500,
//                           child: FutureBuilder<String?>(
//                             future: getImageUrl(product.imagePath.toString()),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState == ConnectionState.waiting) {
//                                 return CircularProgressIndicator();
//                               } else if (snapshot.hasError) {
//                                 return Text('Error loading image');
//                               } else if (snapshot.hasData && snapshot.data != null) {
//                                 return Image.network(
//                                   snapshot.data!,
//                                   width: double.infinity,
//                                   height: 400,
//                                   fit: BoxFit.cover,
//                                 );
//                               } else {
//                                 return SizedBox();
//                               }
//                             },
//                           ),
//
//
//                       ),
//                     ],
//                   ),
//                 ),
//               ), //이미지
//               Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // SizedBox(height: 10),
//                     Padding(
//                         padding: EdgeInsets.only(left:20),
//                         child: Text(
//                           product.name.toString() ?? "Unknown",
//                           style: TextStyle(
//                             color: Color(0xFF23262F),
//                             fontSize: 20,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             height: 0.17,
//                           ),
//                         )
//                     ),
//                   ]
//               ),
//               Container(
//                 height: 70,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 20, right: 30.0), // Adjust the padding as needed
//                   child: Row(
//                     // mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                         width: 70,
//                         height: 25,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Your onPressed logic here
//                           },
//                           style: ButtonStyle(
//                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 side: BorderSide(color: Color(0xFFF6F6F6)),
//                               ),
//                             ),
//                             backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
//                           ),
//                           child: Text(
//                             "#민감성".toUpperCase(),
//                             style: TextStyle(fontSize: 10, color: Colors.white,),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10), // Add space of 10 units between containers
//                       Container(
//                         width: 70,
//                         height: 25,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Your onPressed logic here
//                           },
//                           style: ButtonStyle(
//                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 side: BorderSide(color: Colors.green),
//                               ),
//                             ),
//                             backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
//                           ),
//                           child: Text(
//                             "#지성".toUpperCase(),
//                             style: TextStyle(fontSize: 10, color: Colors.white,),
//                           ),
//                         ),
//                       ),
//                       SizedBox(width: 10), // Add space of 10 units between containers
//                       Container(
//                         width: 70,
//                         height: 25,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Your onPressed logic here
//                           },
//                           style: ButtonStyle(
//                             shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                               RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                                 side: BorderSide(color: Colors.green),
//                               ),
//                             ),
//                             minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
//                             backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
//                           ),
//                           child: Text(
//                             "#건성".toUpperCase(),
//                             style: TextStyle(fontSize: 10, color: Colors.white,),
//                           ),
//                         ),
//                       ),
//                       Divider( // Add a Divider below the container
//                         color: Colors.black, // You can customize the color of the divider
//                         thickness: 1.0, // You can adjust the thickness of the divider
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.all(10.0), // Adjust the padding as needed
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border(
//                       top: BorderSide(
//                         color: Colors.grey.withOpacity(0.5), // Color of the border
//                         width: 1.0, // Thickness of the border
//                       ),
//                     ),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 20),
//                       Padding(
//                         padding: EdgeInsets.only(top: 10, left: 20),
//                         child: Text(
//                           "Ingredients",
//                           style: TextStyle(
//                             color: Color(0xFF23262F),
//                             fontSize: 15,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             height: 0.17,
//                           ),
//                         ),
//                       ),
//                       // Add more content to your Column as needed
//                     ],
//                   ),
//                 ),
//               ), //Address
//               Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                         padding: EdgeInsets.only(top:10,left:30, right:30),
//                         child: Text(
//                           product.ingredients.toString(),
//                           style: TextStyle(
//                             color: Color(0xFF23262F),
//                             fontSize: 12,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             height: 1.5,
//                           ),
//                         )
//                     )
//                   ]
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 20),
//                   Padding(
//                     padding: EdgeInsets.only(top: 10, left: 30),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.star, // Replace with the star icon you want to use
//                           color: Colors.yellow,
//                           size: 50,
//                         ),
//                         SizedBox(width: 5), // Add space between the icon and text
//                         Text(
//                           product.score.toString(),
//                           style: TextStyle(
//                             color: Color(0xFF23262F),
//                             fontSize: 20,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.bold,
//                             height: 0.10,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ), //리뷰스코어
//               Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 0),
//                     Padding(
//                         padding: EdgeInsets.only(top:0,left:85),
//                         child: Text(
//                           "${product.reviewCnt.toString() ?? "Unknown"} ratings",
//                           style: TextStyle(
//                             color: Colors.grey.withOpacity((0.8)),
//                             fontSize: 12,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             height: 0.2,
//                           ),
//                         )
//                     )
//                   ]
//               ), //리뷰개수
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 20),
//                   Padding(
//                     padding: EdgeInsets.only(top: 10, left: 30),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.star, // Replace with the star icon you want to use
//                           color: Colors.yellow,
//                           size: 25,
//                         ),
//                         SizedBox(width: 5), // Add space between the icon and the first text
//                         Text(
//                           product.review?['score'].toString() ?? "Unknown", // Display comment or "Unknown" if null
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 15,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w300,
//                             height: 0.0,
//                           ),
//                         ),
//                       Expanded(
//                         child: Padding(
//                           padding: EdgeInsets.only(right: 20), // Add padding on the right
//                           child: Align(
//                             alignment: Alignment.centerRight,
//                             child: Text(
//                               _formatDate(product.review?['date']) ?? "Unknown",
//                               style: TextStyle(
//                                 color: Colors.grey,
//                                 fontSize: 15,
//                                 fontFamily: 'Inter',
//                                 fontWeight: FontWeight.w300,
//                                 height: 0.0,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 10),
//                     Padding(
//                         padding: EdgeInsets.only(top:10,left:35),
//                         child: Text(
//                           product.review?['userid'] ?? "Unknown", // Display comment or "Unknown" if null
//                           style: TextStyle(
//                             color: Colors.black.withOpacity(0.7),
//                             fontSize: 12,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             height: 0.17,
//                           ),
//                         )
//                     )
//                   ]
//               ),
//               Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: 10),
//                     Padding(
//                         padding: EdgeInsets.only(top:10,left:35,right: 35),
//                         child: Text(
//                           product.review?['comment'] ?? "Unknown", // Display comment or "Unknown" if null
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 12,
//                             fontFamily: 'Inter',
//                             fontWeight: FontWeight.w500,
//                             height: 1.5,
//                           ),
//                         )
//                     )
//                   ]
//               ),
//             ])
//         ),
//       ),
//     );
//   }
// }
//
//


