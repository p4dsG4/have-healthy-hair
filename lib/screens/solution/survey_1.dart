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
        backgroundColor: Colors.white,
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
        color: Colors.white,
        child: SurveyWidget(title: '나의 두피 상태를 선택해주세요.\n(최대 세개까지 선택)',
            minCheck: 1, maxCheck: 3, columns: 2,
            answers: ["양호", "건성", "지성", "민감성", "지루성", "염증성", "비듬성", "탈모성"],
            next: Survey2Screen()
        ),
      ),
      )
    );
  }
}


