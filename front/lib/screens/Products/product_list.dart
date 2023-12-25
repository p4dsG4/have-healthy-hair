import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p4ds/models/product.dart';
import 'package:p4ds/repo/product_repository.dart';
import 'package:p4ds/screens/Products/product_details.dart';
import 'package:firebase_storage/firebase_storage.dart';



class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});



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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center, // Center both items horizontally
                          crossAxisAlignment: CrossAxisAlignment.center, // Center both items vertically
                          children: [
                            Icon(
                              Icons.shopping_basket_rounded, // Replace with the location icon you want to use
                              color: Colors.green, // Customize the color of the location icon
                              size: 30, // Adjust the size of the icon as needed
                            ),
                            SizedBox(width: 10), // Add space between the icon and text
                            Text(
                              'Scalp Products',
                              style: TextStyle(
                                color: Color(0xFF23262F),
                                fontSize: 25,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                height: 0.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  height: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 30.0), // Adjust the padding as needed
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 80,
                          height: 35,
                          child: ElevatedButton(
                            onPressed: () {
                              // Your onPressed logic here
                            },
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide(color: Color(0xFFD6D6D6),),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white), // Set the background color
                            ),
                            child: Text(
                              "All",
                              style: TextStyle(fontSize: 15, color: Colors.black87,),
                            ),
                          ),
                        ),
                        SizedBox(width: 15), // Add space of 10 units between containers
                      ],
                    ),
                  ),
                ), //Text: Check your scalp condition
                ProductList(),
                //탈모병원&샴푸두피케어

              ])
          ),
        ),
    );
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ProductRepository _ProductRepository = ProductRepository();
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
  @override
  Widget build(BuildContext context) {
    return _buildProductList(context);
  }

  Widget _buildProductList(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: _ProductRepository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator(
            strokeWidth: 12.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          );
          return _buildProductListView(context, snapshot.data!.docs);
        },
      )
    );
  }

  Widget _buildProductListView(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      physics: NeverScrollableScrollPhysics(), // Disable scrolling here
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0.0),
      children: snapshot.map((data) => _buildProductListItem(context, data)).toList(),
    );
  }

  Widget _buildProductListItem(BuildContext context, DocumentSnapshot data) {
    final product = Products.fromSnapshot(data);

    return Padding(
      key: ValueKey(product.reviewCnt),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: 350,
        height: 100,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductDetailScreen(product: product)),
            );
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.white),
              ),
            ),
            elevation: MaterialStateProperty.all<double>(1),
            minimumSize: MaterialStateProperty.all(Size(160, 160)),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 3, // Adjust the flex value as needed
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Text(
                      product.name.toString() ?? "Unknown",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20,
                        ),
                        SizedBox(width: 5),
                        Text(
                          product.score.toString() ?? "Unknown",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "(${product.reviewCnt.toString() ?? "Unknown"})",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1, // Adjust the flex value as needed
                child: FutureBuilder<String?>(
                  future: getImageUrl(product.imagePath.toString()),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error loading image');
                    } else if (snapshot.hasData && snapshot.data != null) {
                      return AspectRatio(
                        aspectRatio: 3 / 4, // Adjust the aspect ratio to match your image's aspect ratio
                        child: Image.network(
                          snapshot.data!,
                          fit: BoxFit.contain, // Use BoxFit.contain to fit the entire image within the aspect ratio
                        ),
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

      ),
    );
  }
}