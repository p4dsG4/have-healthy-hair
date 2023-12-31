import 'package:flutter/material.dart';
import 'package:p4ds/screens/solution/survey.dart';
import 'package:p4ds/screens/solution/survey_3.dart';


class Survey2Screen extends StatelessWidget {
  const Survey2Screen({super.key});

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
        child: const SurveyWidget(title: 'Select your gender.',
            minCheck: 1, maxCheck: 1, columns: 2,
            answers: ["Male", "Female"],
            next: Survey3Screen()
        ),
       ),
      ),
    );
  }
}
