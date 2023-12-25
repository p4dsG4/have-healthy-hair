import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:p4ds/repo/image_storage.dart';
import 'package:p4ds/repo/uploadevent_repository.dart';
import 'package:p4ds/screens/scalp/scalp_2.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:p4ds/util/dateutil.dart';

import 'image_process_widget.dart';


class ImageUploadWidget extends StatefulWidget {
  final Function(bool) onAnalysisChanged;

  const ImageUploadWidget({Key? key, required this.onAnalysisChanged}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUploadWidget> {
  bool imageUpload = false;
  String uploadImageUrl = "";
  bool uploading = false;
  bool analyzed = false;

  void imageUploadStarted() {
    setState(() {
      uploading = true;
      analyzed = false;
    });
  }

  void pickImage() async {
    setState(() {
      uploading = true;
    });

    final imageName = 'top_${DateUtil.getYMD(DateTime.now())}';

    ImageStorage.uploadImageToFirebase(
        path: "user1/Scalp",
        imageName: imageName,
        uploadStartCallback: imageUploadStarted
    ).then((url) {
      setState(() {
        imageUpload = true;
        uploadImageUrl = url;
        uploading = false;
      });
      UploadEvent.uploadTimestamp(imageName); // Call function to upload timestamp
      waitAnalyzed(imageName);
      analyzed = false;
    });
  }

  bool uploadError = false;


  void deleteImage(String imageName) async {
    // Helper function to delete a single file
    Future<void> deleteFile(String format) async {
      try {
        await FirebaseStorage.instance
            .ref('user1/Scalp/$imageName.$format')
            .delete();
        print("$format image deleted successfully");
      } catch (e) {
        print("Error deleting $format image: $e");
      }
    }

    // Delete .jpg version
    await deleteFile('jpg');

    // Delete .png version
    await deleteFile('png');
  }


  void waitAnalyzed(String imageName) async {
    try {
      bool analysisResult = false;
      while (!analysisResult) {
        analysisResult = await UploadEvent.getAnalyzeResult(imageName);
        if (analysisResult) {
          setState(() {
            analyzed = true;
            widget.onAnalysisChanged(analyzed);
          });
          print("Analysis complete");
          break;
        } else {
          print("Analysis pending...");
          await Future.delayed(Duration(seconds: 1));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error waiting for image analysis: $e');
      }
      setState(() {
        uploadError = true;
      });
      await Future.delayed(Duration(seconds: 3)); // Increased delay for error
      deleteImage(imageName);
      setState(() {
        imageUpload = false;
        uploadImageUrl = "";
        analyzed = false;
        uploadError = false;
        uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => pickImage(),
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: const BorderSide(color: Colors.white),
          ),
        ),
        minimumSize: MaterialStateProperty.all(const Size(320, 160)), // Adjust the width and height as needed
        backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFEEEEEE)), // Set the background color to light green
      ),
      child: uploading
          ? const CircularProgressIndicator() // Show CircularProgressIndicator while uploading
          : uploadError // Check if there's an upload error
          ? const Text("UPLOAD YOUR SCALP IMAGE AGAIN", style: TextStyle(fontSize: 16, color: Colors.red)) // Show error message
          : (imageUpload
          ? ImageProcessingWidget(uploadImageUrl, !analyzed)
          : const Text("CLICK TO UPLOAD", style: TextStyle(fontSize: 16, color: Colors.black54))),
    );
  }
}

class Scalp1Screen extends StatefulWidget {
  const Scalp1Screen({super.key});

  @override
  State<Scalp1Screen> createState() => _Scalp1ScreenState();
}

class _Scalp1ScreenState extends State<Scalp1Screen> {
  bool isAnalyzed = false;

  void handleAnalysisChanged(bool analyzed) {
    setState(() {
      isAnalyzed = analyzed;
    });
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
          padding: const EdgeInsets.only(top: 16.0), // Adjust the padding as needed
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black54),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SafeArea(
      child: Container(
        color: Color(0xFFEEEEEE),
        child: ListView(children: [
            const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('',
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
                      padding: EdgeInsets.only(left:30),
                      child: Text(
                        'Please upload a photo of the indicated area shown below.',
                        style: TextStyle(
                          color: Color(0xFF23262F),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                        softWrap: true, // Enable text wrapping
                      )
                  )
                ]
            ),
            const SizedBox(height: 40),//Text: Check your scalp condition
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
              child: ImageUploadWidget(onAnalysisChanged: handleAnalysisChanged),
            ),
            const SizedBox(height: 40),//Text: Check your scalp condition
            Center(
              child: ElevatedButton(
                onPressed: isAnalyzed ? () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Scalp2Screen())
                  );
                } : null, // Button is disabled if not analyzed
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (states) {
                      if (states.contains(MaterialState.disabled)) {
                        return Colors.grey; // Grey color when button is disabled
                      }
                      return Colors.green; // Otherwise, green color
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: isAnalyzed ? Colors.green : Colors.grey), // Transparent border when disabled
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(const Size(200, 50)),
                ),
                child: const Text("NEXT", style: TextStyle(fontSize: 16,color: Colors.white)),
              ),
            ),
          ])
        ),
      ),
    );
  }
}
