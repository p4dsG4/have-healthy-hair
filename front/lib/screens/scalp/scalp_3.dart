import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:p4ds/screens/scalp/scalp_4.dart';
import '../../repo/image_storage.dart';
import 'package:intl/intl.dart';

import '../../repo/uploadevent_repository.dart';
import '../../util/dateutil.dart';
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
  bool analyzed3 = false;

  void imageUploadStarted() {
    setState(() {
      uploading = true;
      analyzed3 = false;
    });
  }

  void pickImage() async {
    setState(() {
      uploading = true;
    });

    final imageName = 'left_${DateUtil.getYMD(DateTime.now())}';

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
      analyzed3 = false;

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
            analyzed3 = true;
            widget.onAnalysisChanged(analyzed3);
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
        analyzed3 = false;
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
          ? ImageProcessingWidget(uploadImageUrl, !analyzed3)
          : const Text("CLICK TO UPLOAD", style: TextStyle(fontSize: 16, color: Colors.black54))),
    );
  }

}

class Scalp3Screen extends StatefulWidget {
  const Scalp3Screen({super.key});

  @override
  State<Scalp3Screen> createState() => _Scalp3ScreenState();
}

class _Scalp3ScreenState extends State<Scalp3Screen> {
  bool isAnalyzed3 = false;

  void handleAnalysisChanged(bool analyzed3) {
    setState(() {
      isAnalyzed3 = analyzed3;
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
                      padding: EdgeInsets.only(left:30),
                      child: Text('',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          height: 1.2,
                        ),
                        softWrap: true, // Enable text wrapping
                      ),
                    ),
                    // SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.all(10),
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
                          child: Image.asset('assets/images/scalp/ex3.png')
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
                  onPressed: isAnalyzed3 ? () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Scalp4Screen())
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
                        side: BorderSide(color: isAnalyzed3 ? Colors.green : Colors.grey), // Transparent border when disabled
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
