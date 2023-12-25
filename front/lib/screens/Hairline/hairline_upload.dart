import 'package:flutter/material.dart';
import 'package:p4ds/screens/scalp/scalp_2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:p4ds/screens/scalp/scalp_result.dart';
import '../../repo/image_storage.dart';
import 'Hairline_result.dart';

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
    final imageName = 'Hairline_$formattedDate';

    ImageStorage.uploadImageToFirebase(
        path: "user1/Hairline",
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
      minimumSize: MaterialStateProperty.all(Size(320, 450)), // Adjust the width and height as needed
      backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF6F6F6)), // Set the background color to light grey
    ),
    child: uploading
        ? CircularProgressIndicator() // Show CircularProgressIndicator while uploading
        : Stack(
      alignment: Alignment.center,
      children: [
        if (imageUpload) Image.network(uploadImageUrl, width: 300, height: 350), // Uploaded image
        ColorFiltered(
          colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcATop),
          child: Image.asset('assets/images/home/guide.png', width: 400, height: 450),
        ), // White color filtered tool.png
        if (!imageUpload) Padding(
          padding: EdgeInsets.all(90.0), // You can adjust the padding value as needed
          child: Text(
            "Please click here to upload your photo with your face fitting inside the line.\n\n\n",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ],
    ),
  );
}

}



class HairlineUploadScreen extends StatelessWidget {
  const HairlineUploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEEEEEE),
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
                  // SizedBox(height: 10),
                  Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Please upload a photo of your face. \nMake sure that your hairline is clearly visible.',
                        style: TextStyle(
                          color: Color(0xFF23262F),
                          fontSize: 13,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                      )
                  )
                ]
            ),
            SizedBox(height: 20),//Text: Check your scalp condition
            Center(
              child: ImageUploadWidget()
            ),
            SizedBox(height: 40),//Text: Check your scalp condition
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HairlineResultScreen())
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
                  style: TextStyle(fontSize: 16,color :Colors.white), // You can adjust the font size here
                ),
              ),
            ),
          ])

      ),
      ),
    );
  }
}
