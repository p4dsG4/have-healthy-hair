import 'package:flutter/material.dart';
import 'package:p4ds/screens/solution/survey.dart';

class Survey7Screen extends StatelessWidget {
  const Survey7Screen({super.key});

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
            child: const SurveyWidget(title: 'Select the features you prefer in a product. (Select up to two)',
                minCheck: 1, maxCheck: 2, columns: 2,
                answers: ["None","Cleansing","Cooling","Hair Loss","Moisturizing","Hair Texture","Scent"],
                submitStep: 5,
                next: Survey7Screen()
            ),
          ),
        )
    );
  }
}
