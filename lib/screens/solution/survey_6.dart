import 'package:flutter/material.dart';
import 'package:p4ds/screens/solution/survey_7.dart';
import 'package:p4ds/screens/solution/survey.dart';


class Survey6Screen extends StatelessWidget {
  const Survey6Screen({super.key});


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
      body:  SafeArea(
        child: Container(
          color: Colors.white,
          child: SurveyWidget(title: 'Select your frequency of dyeing/perming hair.',
              minCheck: 1, maxCheck: 1, columns: 2,
              answers: ["Never","Once","<3", ">3"],
              next: Survey7Screen()
          ),

        ),
      ),
    );
  }
}
