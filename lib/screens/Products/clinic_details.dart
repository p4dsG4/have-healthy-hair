import 'package:flutter/material.dart';
import 'package:p4ds/models/clinic.dart';
import 'package:p4ds/screens/Profile/scalp_records.dart';



class ClinicDetailScreen extends StatelessWidget {
  final Clinic clinic;
  const ClinicDetailScreen({super.key, required this.clinic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20,top:20),
            child: IconButton(
              icon: const Icon(Icons.favorite_outline, size: 40, color: Colors.black54),
              onPressed: () {
              },
            ),
          ),
        ],
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
              SizedBox(height: 40),
              Positioned(
                left: 0,
                top: 143,
                child: Container(
                  width: 343,
                  height: 200,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: double.infinity,
                          height: 150,
                          child: Image.asset('assets/images/home/hospital.png')

                      ),
                    ],
                  ),
                ),
              ), //이미지
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(left:20),
                        child: Text(
                          clinic.name ?? "Unknown",
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0.17,
                          ),
                        )
                    ),

                  ]
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.all(10.0), // Adjust the padding as needed
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.grey.withOpacity(0.5), // Color of the border
                        width: 1.0, // Thickness of the border
                      ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          "Address",
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0.17,
                          ),
                        ),
                      ),
                      // Add more content to your Column as needed
                    ],
                  ),
                ),
              ), //Address
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: EdgeInsets.only(top:10,left:30),
                        child: Text(
                          clinic.address ?? "Unknown",
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0.17,
                          ),
                        )
                    )
                  ]
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Padding(
                        padding: EdgeInsets.only(top:10,left:30),
                        child: Text(
                          "Phone number",
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            height: 0.17,
                          ),
                        )
                    )
                  ]
              ), // phone
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(top:10,left:30),
                        child: Text(
                          clinic.phone ?? "Unknown",
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0.17,
                          ),
                        )
                    )
                  ]
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30),
                    Padding(
                        padding: EdgeInsets.only(top:10,left:30),
                        child: Text(
                          "Webpage",
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            height: 0.17,
                          ),
                        )
                    )
                  ]
              ), // URL
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(top:10,left:30),
                        child: Text(
                          clinic.url ?? "Unknown",
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 13,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0.17,
                          ),
                        )
                    )
                  ]
              ),
            ])
        ),
      ),
    );
  }
}
