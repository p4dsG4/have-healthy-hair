import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p4ds/models/product.dart';
import 'package:p4ds/repo/product_repository.dart';
import 'package:p4ds/screens/Products/product_details.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/clinic.dart';
import '../../repo/clinic_repository.dart';
import '../Products/clinic_details.dart';


class SolutionResultScreen extends StatelessWidget {
  final String productKey;
  const SolutionResultScreen(this.productKey, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () => Navigator.of(context).popUntil((route)=>route.isFirst)
            ,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
            color: Colors.white,
            child: ListView(
                children: [
                  // Header Section
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Scalp Products for You!',
                        style: TextStyle(
                          color: Color(0xFF23262F),
                          fontSize: 25,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  // Product List
                  ProductList(productKey: productKey),
                  SizedBox(height: 50),
                  // Clinic List
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Clinics for You!',
                        style: TextStyle(
                          color: Color(0xFF23262F),
                          fontSize: 25,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  ClinicList(),
            ])
        ),
      ),
    );
  }
}



class ProductList extends StatefulWidget {
  final String productKey;

  ProductList({Key? key, required this.productKey}) : super(key: key);

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
          stream: FirebaseFirestore.instance
              .collection('products')
              .where('TF', isEqualTo: widget.productKey) // Filter products based on TF field
              .snapshots(),
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
            elevation: MaterialStateProperty.all<double>(5.0),
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




GlobalKey<_ClinicListState> clinicListKey = GlobalKey();
class ClinicList extends StatefulWidget {
  ClinicList({Key? key}) : super(key: key);

  @override
  _ClinicListState createState() => _ClinicListState();
}

class _ClinicListState extends State<ClinicList> {
  Stream<QuerySnapshot>? clinicStream;
  final ClinicRepository _clinicRepository = ClinicRepository();
  final String currentUserDocId = "eAzkQ6yq21k05Bzp7xvU"; // User document ID
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    initClinicList();
  }

  void initClinicList() async {
    String userZipCode = await fetchUserZipCode();
    showNearbyClinics(userZipCode);
  }

  Future<String> fetchUserZipCode() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUserDocId).get();
    return userDoc['ZIPCD'] ?? "";
  }

  void showNearbyClinics(String zipCode) {
    setState(() {
      clinicStream = _clinicRepository.getStreamWithZip(zipCode);
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    return _buildClinicList(context);
  }

  Widget _buildClinicList(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: clinicStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (!snapshot.hasData) return CircularProgressIndicator();
        return _buildClinicListView(context, snapshot.data!.docs);
      },
    );
  }


  Widget _buildClinicListView(BuildContext context,
      List<DocumentSnapshot> snapshot) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: snapshot.length,
      itemBuilder: (context, index) =>
          _buildClinicListItem(context, snapshot[index]),
    );
  }

  Widget _buildClinicListItem(BuildContext context, DocumentSnapshot data) {
    final clinic = Clinic.fromSnapshot(data);
    return Padding(
      key: ValueKey(clinic.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        width: 350,
        height: 100,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ClinicDetailScreen(clinic: clinic)),
            );
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(color: Colors.white),
              ),
            ),
            elevation: MaterialStateProperty.all<double>(5.0),
            // Add elevation (shadow) to the button
            minimumSize: MaterialStateProperty.all(Size(160, 160)),
            // Adjust the width and height as needed
            backgroundColor: MaterialStateProperty.all<Color>(
                Colors.white), // Set the background color
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  // Adjust the top and left padding as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clinic.name ?? "Unknown",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      // Add vertical space between the two texts
                      Text(
                        clinic.address ?? "Unknown",
                        style: TextStyle(
                          fontSize: 14, // Adjust the font size as needed
                          color: Colors.grey, // Customize the color of the text
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
    );
  }
}
