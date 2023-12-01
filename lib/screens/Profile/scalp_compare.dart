import 'package:flutter/material.dart';
import 'package:p4ds/screens/Profile/scalp_records.dart';
import 'package:p4ds/models/scalp.dart';
import 'package:flutter/material.dart';
import 'package:p4ds/models/scalp.dart'; // Import Scalp model
import 'package:p4ds/repo/scalp_repository.dart'; // Import ScalpRepository
import 'package:cloud_firestore/cloud_firestore.dart';


class ScalpCompareScreen extends StatefulWidget {
  @override
  _ScalpCompareScreenState createState() => _ScalpCompareScreenState();
}

class _ScalpCompareScreenState extends State<ScalpCompareScreen> {
  final ScalpRepository scalpRepository = ScalpRepository();
  Map<String, dynamic>? currentData;
  String selectedScalpArea = ''; // New variable to track the selected scalp area


  // Mapping from original key names to new names
  final Map<String, String> keyNameMapping = {
    'Type1': '미세각질',
    'Type2': '피지과다',
    'Type3': '모낭사이홍반',
    'Type4': '모낭홍반/농포',
    'Type5': '비듬',
    'Type6': '탈모',
    // Add other key mappings here if needed
  };

  Widget scalpButton(Scalp scalp) {
    return Container(
      width: 300,
      height: 250,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Image.asset(
              'assets/images/home/head.png',
              width: 300,
              height: 250,
            ),
          ),
          Positioned( // Top
            left: 119,
            top: 10,
            child: GestureDetector(
              onTap: () => setState(() {
                currentData = scalp.top;
                selectedScalpArea = 'top';
              }),
              child: Container(
                width: 70,
                height: 60,
                color: _getColorForCondition(scalp.top?['Condition'], selectedScalpArea == 'top'),
              ),
            ),
          ),
          Positioned( // Back
            left: 119,
            top: 120,
            child: GestureDetector(
              onTap: () => setState(() {
                currentData = scalp.back;
                selectedScalpArea = 'back';
              }),
              child: Container(
                width: 70,
                height: 60,
                color: _getColorForCondition(scalp.back?['Condition'], selectedScalpArea == 'back'),
              ),
            ),
          ),
          Positioned( // Left
            left: 50,
            top: 70,
            child: GestureDetector(
              onTap: () => setState(() {
                currentData = scalp.left;
                selectedScalpArea = 'left';
              }),
              child: Container(
                width: 60,
                height: 70,
                color: _getColorForCondition(scalp.left?['Condition'], selectedScalpArea == 'left'),
              ),
            ),
          ),
          Positioned( // Right
            left: 200,
            top: 70,
            child: GestureDetector(
              onTap: () => setState(() {
                currentData = scalp.right;
                selectedScalpArea = 'right';
              }),
              child: Container(
                width: 60,
                height: 70,
                color: _getColorForCondition(scalp.right?['Condition'], selectedScalpArea == 'right'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getColorForCondition(String? condition, bool isSelected) {
    double opacity = isSelected ? 0.9 : 0.3; // Higher opacity if selected

    switch (condition) {
      case 'Good':
        return Colors.green.withOpacity(opacity);
      case 'Dry' :
        return Colors.yellow.withOpacity(opacity);
      case 'Oily' :
        return Colors.yellow.withOpacity(opacity);
      case 'Sensitive':
        return Colors.orange.withOpacity(opacity);
      case 'Infammatory':
        return Colors.orange.withOpacity(opacity);
      case 'Seborrheic':
        return Colors.orange.withOpacity(opacity);
      case 'Dandruff' :
        return Colors.yellow.withOpacity(opacity);
      case 'Hairloss':
        return Colors.red.withOpacity(opacity);
      default:
        return Colors.transparent.withOpacity(0.5); // Default color if condition is null or doesn't match
    }
  }

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
              Navigator.of(context).popUntil((route)=>route.isFirst);
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: scalpRepository.getStream(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();

          Scalp scalp = Scalp.fromSnapshot(snapshot.data!.docs.first);

          // Initialize currentData with Top data if not already set
          if (currentData == null && scalp.top != null) {
            currentData = scalp.top;
          }
          String condition = currentData?['Condition'] ?? '정보 없음';

          return Column(
            children: <Widget>[
              // SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 30),
                  child: Text(
                    '얼마나 나아졌게요?',
                    style: TextStyle(
                      color: Color(0xFF23262F),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
              Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                      padding: EdgeInsets.only(left: 220),
                      child: Text(
                        '$condition',
                        style: TextStyle(
                          color: Color(0xFF23262F),
                          fontSize: 28,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ],
                        ),
                      )
                  )),
              SizedBox(height: 20),
              scalpButton(scalp),
              Padding(
                padding: EdgeInsets.only(left: 130), // Adjust the left padding as needed
                child: Row(
                  children: [
                    Text(
                      '-3',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                    SizedBox(width: 23),
                    Text(
                      '-2',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                    SizedBox(width: 23),
                    Text(
                      '-1',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                    SizedBox(width: 23),
                    Text(
                      '0',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                    SizedBox(width: 23),
                    Text(
                      '+1',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                    SizedBox(width: 23),
                    Text(
                      '+2',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                    SizedBox(width: 23),
                    Text(
                      '+3',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: currentData != null
                    ? _buildProgressIndicators(currentData)
                    : Text('원하는 부위를 누르세요'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildButton(String title, Map<String, dynamic>? data) {
    return ElevatedButton(
      onPressed: () => setState(() {
        currentData = data;
      }),
      child: Text(title),
    );
  }

  Widget _buildProgressIndicators(Map<String, dynamic>? data) {
    return ListView(
      children: data!.entries.where((entry) {
        // Exclude 'condition' and 'image' fields
        return entry.key != 'Condition' && entry.key != 'image';
      }).map((entry) {
        int value = int.tryParse(entry.value.toString()) ?? 0; // Convert to int
        String displayName = keyNameMapping[entry.key] ?? entry.key; // Get new name or use original key if not found

        return Padding(
          padding: const EdgeInsets.only(top: 10.0, left: 20, right: 30, bottom:10),
          child: Row(
            children: <Widget>[
              Container(
                width: 100, // Fixed width for the text
                child: Text(displayName, overflow: TextOverflow.ellipsis), // Text with ellipsis in case of overflow
              ),
              SizedBox(width: 8.0), // A little space between the text and the indicator
              Expanded( // Progress indicator takes the remaining space
                child: LinearProgressIndicator(
                  value: _normalize(value),
                  backgroundColor: Colors.grey[300],
                  color: Colors.green,
                  minHeight: 8, // Adjust the height of the progress indicator as needed
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }



  double _normalize(int value) {
    // Adjust the normalization logic based on the maximum possible value
    int maxValue = 3; // Example max value, adjust as necessary
    return value / maxValue;
  }
}





