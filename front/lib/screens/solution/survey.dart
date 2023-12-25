import 'package:flutter/material.dart';
import 'package:p4ds/screens/solution/solution_result.dart';
import 'package:p4ds/screens/solution/toggle_button.dart';

class SurveyWidget extends StatefulWidget {
  const SurveyWidget({super.key,
    this.columns = 2,
    required this.title,
    required this.minCheck,
    required this.maxCheck,
    required this.answers,
    this.submitStep,
    required this.next});

  final String title;
  final int columns;
  final int minCheck;
  final int maxCheck;
  final List<String> answers;
  final int? submitStep;
  final StatelessWidget next;
  
  @override
  State<StatefulWidget> createState() => _SurveyState();
}

class SurveyData {
  static String step1BinaryRepresentation = "";
}

class _SurveyState extends State<SurveyWidget> {
  int selectedCount = 0;
  List<bool> buttonStates = List.filled(8, false); // Assuming 8 buttons

  void toggleButton(int index, bool selected) {
    setState(() {
      buttonStates[index] = selected;
      selectedCount += selected ? 1 : -1;
    });
  }


  @override
  void initState() {
    super.initState();
    // Initialize buttonStates based on the number of answers
    buttonStates = List.filled(widget.answers.length, false);
  }

  String getBinaryRepresentation() {
    return buttonStates.map((state) => state ? '1' : '0').join();
  }

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
          const SizedBox(height: 40),
          Expanded(child: GridView.count(
              padding: const EdgeInsets.only(left:33, right:33),
              crossAxisSpacing: 20,
              mainAxisSpacing: 50,
              childAspectRatio: 4 / 2, // Width to height ratio (adjust as needed)
              crossAxisCount: widget.columns,
              children: widget.answers.asMap().entries.map((entry) {
                int index = entry.key;
                String answer = entry.value;
                return ToggleButton(
                  text: answer,
                  selected: buttonStates[index],
                  onPressed: () => toggleButton(index, !buttonStates[index]),
                  disabled: isOverMax && !buttonStates[index],
                );
              }).toList(),          )),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed:isNextEnabled?  () {
                String binaryRepresentation = getBinaryRepresentation();

                print("Submit Step : $binaryRepresentation");
                if(widget.submitStep == 1){
                  SurveyData.step1BinaryRepresentation = getBinaryRepresentation();
                  print("Submit Step 1: ${SurveyData.step1BinaryRepresentation}");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => widget.next));
                }
                else if(widget.submitStep == 5){
                  String binaryRepresentationStep5 = getBinaryRepresentation();
                  String combinedRepresentation = SurveyData.step1BinaryRepresentation + binaryRepresentationStep5;
                  print("Submit Step 5: $combinedRepresentation");
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SolutionResultScreen(combinedRepresentation)));
                }
                else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => widget.next));
                }
              } : null,
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.transparent)
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
                style: TextStyle(fontSize: 16,color :Colors.white), // You can adjust the font size here
              ),
            ),
          ),
          const SizedBox(height: 30)
        ]
    );
  }
}

