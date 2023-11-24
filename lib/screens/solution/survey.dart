import 'package:flutter/material.dart';
import 'package:p4ds/screens/solution/toggle_button.dart';

class SurveyWidget extends StatefulWidget {
  const SurveyWidget({super.key,
    this.columns = 2,
    required this.title,
    required this.minCheck,
    required this.maxCheck,
    required this.answers,
    required this.next});

  final String title;
  final int columns;
  final int minCheck;
  final int maxCheck;
  final List<String> answers;
  final StatelessWidget next;
  
  @override
  State<StatefulWidget> createState() => _SurveyState();
}

class _SurveyState extends State<SurveyWidget> {
  int selectedCount = 0;

  @override
  Widget build(BuildContext context) {
    bool isNextEnabled = (selectedCount >= widget.minCheck);
    bool isOverMax = (selectedCount >= widget.maxCheck);
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              widget.title,
              style: const TextStyle(
                color: Color(0xFF23262F),
                fontSize: 20,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
              softWrap: true, // Enable text wrapping
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(child: GridView.count(
              padding: const EdgeInsets.all(80),
              crossAxisSpacing: 5,
              mainAxisSpacing: 4,
              crossAxisCount: widget.columns,
              children: widget.answers.map((answer) => ToggleButton(answer,
                onPressed: (selected) => setState(() => selected ? selectedCount++ : selectedCount--),
                disabled: isOverMax,
              )).toList()
          )),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed:isNextEnabled?  () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => widget.next));
              } : null,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.green)
                  ),
                ),
                minimumSize: MaterialStateProperty.all(const Size(280, 50)), // Adjust the width and height as needed
                backgroundColor: 
                  isNextEnabled ? 
                    MaterialStateProperty.all<Color>(Colors.green)
                    : MaterialStateProperty.all<Color>(Colors.grey), // Set the background color to light green
              ),
              child: Text(
                "Next".toUpperCase(),
                style: const TextStyle(fontSize: 16), // You can adjust the font size here
              ),
            ),
          ),
          const SizedBox(height: 30)
        ]
    );
  }
}

