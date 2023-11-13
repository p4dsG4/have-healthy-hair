import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class SolutionResultScreen extends StatelessWidget {
  const SolutionResultScreen({super.key});

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
                            '당신의 두피고민에 딱 맞춘 상품',
                            style: TextStyle(
                              color: Color(0xFF23262F),
                              fontSize: 20,
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
                    height: 350,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: double.infinity,
                            height: 350,
                            child: Image.asset('assets/images/home/solution.png')

                        ),
                      ],
                    ),
                  ),
                ),


              ])
          ),
        ),


    );
  }
}
