import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p4ds/models/clinic.dart';
import 'package:p4ds/repo/clinic_repository.dart';
import 'package:p4ds/screens/Products/clinic_details.dart';

class ClinicScreen extends StatelessWidget {
  final String currentUserDocId = "eAzkQ6yq21k05Bzp7xvU"; // Replace with actual user document ID
  const ClinicScreen({super.key});

  pickImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery);
  }

  Future<String> fetchUserZipCode() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection(
        'users').doc(currentUserDocId).get();
    print(userDoc['ZIPCD']);
    return userDoc['ZIPCD'] ??
        ""; // Assuming ZIPCD field exists in user document
  }

  void showAllClinics(BuildContext context) {
    clinicListKey.currentState?.showAllClinics();
  }

  void showNearbyClinics(BuildContext context) async {
    String userZipCode = await fetchUserZipCode();
    clinicListKey.currentState?.showNearbyClinics(userZipCode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFEEEEEE),
        shadowColor: Colors.transparent,
        leading: Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Color(0xFFEEEEEE),
          child: ListView(
            children: [
              SizedBox(height: 5),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, color: Colors.green, size: 30),
                    SizedBox(width: 10),
                    Text('Hospital/Clinic', style: TextStyle(
                        color: Color(0xFF23262F),
                        fontSize: 25,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 30.0),
                child: Row(
                  children: [
                    _buildButton("All", () => showAllClinics(context)),
                    SizedBox(width: 15),
                    _buildButton("Nearby", () => showNearbyClinics(context)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              ClinicList(key: clinicListKey),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed) {
    return Container(
      width: 90,
      height: 35,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Color(0xFFD6D6D6),), // Make the border transparent
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        ),
        child: Text(
            text, style: TextStyle(fontSize: 13, color: Colors.black87)),
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

  @override
  void initState() {
    super.initState();
    showAllClinics();
  }

  void showAllClinics() {
    setState(() => clinicStream = _clinicRepository.getStream());
  }

  void showNearbyClinics(String zipCode) {
    setState(() => clinicStream = _clinicRepository.getStreamWithZip(zipCode));
  }

  @override
  Widget build(BuildContext context) {
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
      physics: NeverScrollableScrollPhysics(), // Disable scrolling here
      shrinkWrap: true,
      itemCount: snapshot.length,
      itemBuilder: (context, index) =>
          _buildClinicListItem(context, snapshot[index]),
    );
  }

  Widget _buildClinicListItem(BuildContext context, DocumentSnapshot data) {
    final clinic = Clinic.fromSnapshot(data);
    return Container(
      color: Color(0xFFEEEEEE),
      child: Padding(
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
              elevation: MaterialStateProperty.all<double>(1),
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
                            fontSize: 17,
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
                            color: Colors.grey.shade600, // Customize the color of the text
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
      ),
    );
  }
}
