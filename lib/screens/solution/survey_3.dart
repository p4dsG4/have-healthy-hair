import 'package:flutter/material.dart';
import 'package:p4ds/screens/solution/survey_4.dart';


class Survey3Screen extends StatelessWidget {
  const Survey3Screen({super.key});


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
                crossAxisAlignment: CrossAxisAlignment.center, // Align children in the center horizontally
                children: [
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '나이를 선택해주세요.',
                      style: TextStyle(
                        color: Color(0xFF23262F),
                        fontSize: 18,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        height: 0.17,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),//Text: Check your scalp condition
              Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0), // Adjust the padding as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 120,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFFF6F6F6)),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F2F2)), // Set the background color
                          ),
                          child: Text(
                            "10세이하".toUpperCase(),
                            style: TextStyle(fontSize: 18, color: Colors.black87,),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFFF6F6F6)),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F2F2)), // Set the background color
                          ),
                          child: Text(
                            "10 ~ 19세".toUpperCase(),
                            style: TextStyle(fontSize: 18, color: Colors.black87,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0), // Adjust the padding as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 120,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFFF6F6F6)),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F2F2)), // Set the background color
                          ),
                          child: Text(
                            "20~29세".toUpperCase(),
                            style: TextStyle(fontSize: 18, color: Colors.black87,),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFFF6F6F6)),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F2F2)), // Set the background color
                          ),
                          child: Text(
                            "30~30세".toUpperCase(),
                            style: TextStyle(fontSize: 18, color: Colors.black87,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0), // Adjust the padding as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 120,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFFF6F6F6)),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F2F2)), // Set the background color
                          ),
                          child: Text(
                            "40~49세".toUpperCase(),
                            style: TextStyle(fontSize: 18, color: Colors.black87,),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFFF6F6F6)),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F2F2)), // Set the background color
                          ),
                          child: Text(
                            "50~59세".toUpperCase(),
                            style: TextStyle(fontSize: 18, color: Colors.black87,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0), // Adjust the padding as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: 120,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFFF6F6F6)),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F2F2)), // Set the background color
                          ),
                          child: Text(
                            "60~69세".toUpperCase(),
                            style: TextStyle(fontSize: 18, color: Colors.black87,),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 70,
                        child: ElevatedButton(
                          onPressed: () {
                            // Your onPressed logic here
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(color: Color(0xFFF6F6F6)),
                              ),
                            ),
                            minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFF3F2F2)), // Set the background color
                          ),
                          child: Text(
                            "70세 이상".toUpperCase(),
                            style: TextStyle(fontSize: 18, color: Colors.black87,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),//Text: Check your scalp condition
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Survey4Screen() )
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(280, 50)), // Adjust the width and height as needed
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
