import 'package:flutter/material.dart';
import 'package:p4ds/screens/scalp/scalp_2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../repo/image_storage.dart';

class ImageUploadWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUploadWidget> {
  bool imageUpload = false;
  String uploadImageUrl = "";
  bool uploading = false;

  void imageUploadStarted() {
    setState(() {
      uploading = true;
    });
  }

  void uploadTimestamp(String imageName) {
    FirebaseFirestore.instance.collection('upload_events').doc(imageName).set({
      'timestamp': FieldValue.serverTimestamp() // Use server timestamp
    }, SetOptions(merge: true)) // Merge with existing data if the document already exists
        .then((_) {
      print('Timestamp added for image: $imageName');
    }).catchError((error) {
      print('Error adding timestamp: $error');
    });
  }


  void pickImage() async {
    setState(() {
      uploading = true;
    });

    final formattedDate = DateFormat('yyyyMMdd').format(DateTime.now());
    final imageName = 'Top_$formattedDate';

    ImageStorage.uploadImageToFirebase(
        path: "user1",
        imageName: imageName,
        uploadStartCallback: imageUploadStarted
    ).then((url) {
      setState(() {
        imageUpload = true;
        uploadImageUrl = url;
        uploading = false;
      });
      uploadTimestamp(imageName); // Call function to upload timestamp
      print(url);
    });
  }


@override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => pickImage(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.white),
          ),
        ),
        minimumSize: MaterialStateProperty.all(Size(320, 160)), // Adjust the width and height as needed
        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF6F6F6)), // Set the background color to light green
      ),
      child: uploading
          ? CircularProgressIndicator() // Show CircularProgressIndicator while uploading
          : imageUpload
          ? Image.network(
        uploadImageUrl,
        width: 100,
        height: 100,
      )
          : Text(
        "Click to upload".toUpperCase(),
        style: TextStyle(fontSize: 16, color: Colors.grey,),
        // You can adjust the font size here
      ),
    );
  }
}



class Scalp1Screen extends StatelessWidget {
  const Scalp1Screen({super.key});

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
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  // SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Please upload a photo of the indicated area shown below.',
                        style: TextStyle(
                          color: Color(0xFF23262F),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0.17,
                        ),
                      )
                  )
                ]
            ),
            SizedBox(height: 40),//Text: Check your scalp condition
            Positioned(
              left: 17,
              top: 143,
              child: Container(
                width: 343,
                height: 250,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: double.infinity,
                        height: 180,
                        child: Image.asset('assets/images/scalp/ex1.png')

                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: ImageUploadWidget()
            ),
            SizedBox(height: 40),//Text: Check your scalp condition
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Scalp2Screen() )
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.green),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color to light green
                ),
                child: Text(
                  "Next".toUpperCase(),
                  style: TextStyle(fontSize: 16), // You can adjust the font size here
                ),
              ),
            ),
          ])

      ),
      ),
    );
  }
}
