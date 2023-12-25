import 'package:flutter/material.dart';
import 'package:p4ds/screens/Profile/scalp_records.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../repo/image_storage.dart';
import '../../util/dateutil.dart';

class _ScalpState extends State<ScalpStateWidget> {
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    try {
      String url = await ImageStorage.waitUntilAvailable('user1/Hairline/result/source_target.png');
      setState(() {
        imageUrl = url;
      });
    } catch (e) {
      print(e); // Handle the error in a way that's appropriate for your app
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300,
          height: 400,
          child: imageUrl == null
              ? CircularProgressIndicator() // Show a loader while the image is loading
              : Image.network(
            imageUrl!,
            width: 300,
            height: 400,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}



class ScalpStateWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => _ScalpState();

}


class HairlineResultScreen extends StatelessWidget {
  const HairlineResultScreen({super.key});

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
              Navigator.of(context).popUntil((route)=>route.isFirst);
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
                          padding: EdgeInsets.only(left: 40),
                          child: Text(
                            'When you get old without Scalp Care...',
                            style: TextStyle(
                              color: Color(0xFF23262F),
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w500,
                              height: 1.5,
                            ),
                            softWrap: true,
                          )
                      )
                    ]
                ),
                SizedBox(height: 20),
                ScalpStateWidget(),
                SizedBox(height: 20),

                // Center(
                //   child: ElevatedButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => const ScalpRecordsScreen() )
                //       );
                //     },
                //     style: ButtonStyle(
                //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(18.0),
                //           side: BorderSide(color: Colors.green),
                //         ),
                //       ),
                //       minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                //       backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color to light green
                //     ),
                //     child: Text(
                //       "나의 두피 기록".toUpperCase(),
                //       style: TextStyle(fontSize: 16), // You can adjust the font size here
                //     ),
                //   ),
                // ),



              ])
          ),
        ),


    );
  }
}
