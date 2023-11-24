import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p4ds/models/clinic.dart';
import 'package:p4ds/repo/clinic_repository.dart';
import 'package:p4ds/screens/Products/clinic_details.dart';



class ClinicScreen extends StatelessWidget {
  const ClinicScreen({super.key});

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
                            '클리닉',
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
                ClinicList(),
                //탈모병원&샴푸두피케어

              ])
          ),
        ),
    );
  }
}

class ClinicList extends StatefulWidget {
  @override
  _ClinicListState createState() => _ClinicListState();
}

class _ClinicListState extends State<ClinicList> {
  final ClinicRepository _clinicRepository = ClinicRepository();
  @override
  Widget build(BuildContext context) {
    return _buildClinicList(context);
  }

  Widget _buildClinicList(BuildContext context) {
    return Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: _clinicRepository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator(
            strokeWidth: 12.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
          );
          return _buildClinicListView(context, snapshot.data!.docs);
        },
      )
    );
  }

  Widget _buildClinicListView(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildClinicListItem(context, data)).toList(),
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
              MaterialPageRoute(builder: (context) => ClinicDetailScreen(clinic: clinic)),
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
                    clinic.name ?? "Unknown",
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