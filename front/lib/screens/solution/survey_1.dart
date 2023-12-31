import 'package:flutter/material.dart';
import 'package:p4ds/screens/solution/survey.dart';
import 'package:p4ds/screens/solution/survey_2.dart';


class Survey1Screen extends StatelessWidget {
  const Survey1Screen({super.key});

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
        child: const SurveyWidget(title: 'Select your scalp conditions.\n(Select up to three)',
            minCheck: 1, maxCheck: 3, columns: 2,
            answers: ["Good", "Dry", "Oily", "Sensitive", "Seborrheic", "Inflammatory", "Dandruff", "Hairloss"],
            submitStep: 1,
            next: Survey2Screen()
        ),
      ),
      )
    );
  }
}


