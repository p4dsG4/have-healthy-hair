import 'package:flutter/material.dart';
import 'package:p4ds/screens/Profile/scalp_records.dart';



class ClinicDetailScreen extends StatelessWidget {
  const ClinicDetailScreen({super.key});

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
                          '클리닉 이름 가져오기',
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
              Container(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 30.0), // Adjust the padding as needed
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 70,
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Color(0xFFF6F6F6)),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
                          ),
                          child: Text(
                            "#민감성".toUpperCase(),
                            style: TextStyle(fontSize: 10, color: Colors.white,),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Add space of 10 units between containers
                      Container(
                        width: 70,
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.green),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
                          ),
                          child: Text(
                            "#지성".toUpperCase(),
                            style: TextStyle(fontSize: 10, color: Colors.white,),
                          ),
                        ),
                      ),
                      SizedBox(width: 10), // Add space of 10 units between containers
                      Container(
                        width: 70,
                        height: 25,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.green),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color
                          ),
                          child: Text(
                            "#건성".toUpperCase(),
                            style: TextStyle(fontSize: 10, color: Colors.white,),
                          ),
                        ),
                      ),
                      Divider( // Add a Divider below the container
                        color: Colors.black, // You can customize the color of the divider
                        thickness: 1.0, // You can adjust the thickness of the divider
                      ),
                    ],
                  ),
                ),
              ),
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
                      SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(top: 10, left: 20),
                        child: Text(
                          'Address',
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
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(top:10,left:30),
                        child: Text(
                          '주소 가져오기',
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
                          'Phone number',
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
                          '전화번호 가져오기',
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
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star, // Replace with the star icon you want to use
                          color: Colors.yellow,
                          size: 50,
                        ),
                        SizedBox(width: 5), // Add space between the icon and text
                        Text(
                          '리뷰 스코어 가져오거나 계산',
                          style: TextStyle(
                            color: Color(0xFF23262F),
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            height: 0.10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ), //리뷰스코어
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0),
                    Padding(
                        padding: EdgeInsets.only(top:0,left:85),
                        child: Text(
                          '리뷰 개수',
                          style: TextStyle(
                            color: Colors.grey.withOpacity((0.8)),
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0.2,
                          ),
                        )
                    )
                  ]
              ), //리뷰개수
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 30),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star, // Replace with the star icon you want to use
                          color: Colors.yellow,
                          size: 25,
                        ),
                        SizedBox(width: 5), // Add space between the icon and the first text
                        Text(
                          '유저 리뷰 스코어',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w300,
                            height: 0.0,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: 20), // Add padding on the right
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                '날짜가져오기', // Your additional text here
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w300,
                                  height: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(top:10,left:35),
                        child: Text(
                          '유저명 가져오기 ',
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
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
                    SizedBox(height: 10),
                    Padding(
                        padding: EdgeInsets.only(top:10,left:35),
                        child: Text(
                          '리뷰 내용 가져오기',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
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
