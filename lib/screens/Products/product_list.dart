import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p4ds/models/shampoo.dart';
import 'package:p4ds/repo/shampoo_repository.dart';
import 'package:p4ds/screens/Products/shampoo_details.dart';



class ShampooScreen extends StatelessWidget {
  const ShampooScreen({super.key});

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
              Navigator.pop(context);
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
                            '샴푸',
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
                ShampooList(),
                //탈모병원&샴푸두피케어

              ])
          ),
        ),
    );
  }
}

class ShampooList extends StatefulWidget {
  @override
  _ShampooListState createState() => _ShampooListState();
}

class _ShampooListState extends State<ShampooList> {
  final ShampooRepository _ShampooRepository = ShampooRepository();
  @override
  Widget build(BuildContext context) {
    return _buildShampooList(context);
  }

  Widget _buildShampooList(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: _ShampooRepository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator(
            strokeWidth: 12.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          );
          return _buildShampooListView(context, snapshot.data!.docs);
        },
      )
    );
  }

  Widget _buildShampooListView(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildShampooListItem(context, data)).toList(),
    );
  }

  Widget _buildShampooListItem(BuildContext context, DocumentSnapshot data) {
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
              MaterialPageRoute(builder: (context) => ShampooDetailScreen(product: product)),
            );
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
                    product.reviewCnt ?? "Unknown",
                    style: TextStyle(fontSize: 18, color: Colors.black87,),
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