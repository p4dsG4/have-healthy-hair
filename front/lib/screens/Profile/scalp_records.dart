import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p4ds/models/product.dart';
import 'package:p4ds/repo/product_repository.dart';
import 'package:p4ds/screens/Profile/scalp_compare.dart';
import 'package:p4ds/screens/scalp/scalp_result.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../models/scalp.dart';
import '../../repo/scalp_repository.dart';



class ScalpRecordScreen extends StatelessWidget {
  const ScalpRecordScreen({super.key});



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
                            Icons.insert_drive_file, // Replace with the desired icon
                            color: Colors.green, // Customize the color of the location icon
                            size: 27, // Adjust the size of the icon as needed
                          ),
                          SizedBox(width: 10), // Add space between the icon and text
                          Text(
                            'My Records',
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
              ScalpRecordList(),
            ])
        ),
      ),
    );
  }
}

class ScalpRecordList extends StatefulWidget {
  List<String> checkedList = List.empty(growable: true);

  @override
  _ScalpRecordListState createState() => _ScalpRecordListState();
}

class _ScalpRecordListState extends State<ScalpRecordList> {
  final ScalpRepository _ScalpRepository = ScalpRepository();


  Future<String?> getImageUrl(String imagePath) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(imagePath);
      final downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error getting image URL: $e');
      print(imagePath);
      return null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return _buildScalpRecordList(context);
  }

  Widget _buildScalpRecordList(BuildContext context) {
    return Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _ScalpRepository.getStream(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator(
              strokeWidth: 12.0,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            );
            return _buildScalpRecordListView(context, snapshot.data!.docs);
          },
        )
    );
  }

  Widget _buildScalpRecordListView(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
        physics: NeverScrollableScrollPhysics(), // Disable scrolling here
        shrinkWrap: true,
      padding: const EdgeInsets.only(top: 0.0),
      children: snapshot.map((data) => _buildScalpRecordListItem(context, data)).toList() +
          [
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScalpCompareScreen(widget.checkedList))
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.green),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                ),
                child: Text(
                  "Compare".toUpperCase(),
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ]
    );
  }

  Widget _buildScalpRecordListItem(BuildContext context, DocumentSnapshot data) {
    final scalp = Scalp.fromSnapshot(data);


    return Padding(
      key: ValueKey(scalp),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        children: [
          Container(
            width: 350,
            height: 100,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ScalpResultScreen(sculpKey: data.id)),
                );
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                elevation: MaterialStateProperty.all<double>(1.0),
                minimumSize: MaterialStateProperty.all(Size(160, 160)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3, // Adjust the flex value as needed
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: widget.checkedList.contains(data.id),
                          onChanged: (bool? value) {
                            setState(() {
                              if(value!){
                                widget.checkedList.add(data.id);
                              }else{
                                widget.checkedList.remove(data.id);
                              }
                              print(widget.checkedList);
                            });
                          },
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Scalp Condition",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Date: ${data.id ?? "Unknown"}",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ]
                        )
                      ]
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