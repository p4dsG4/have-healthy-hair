import 'dart:async';
import 'package:flutter/material.dart';
import 'package:p4ds/screens/Profile/scalp_records.dart';
import 'package:p4ds/models/scalp.dart';
import 'package:p4ds/repo/scalp_repository.dart'; // Import ScalpRepository
import 'package:p4ds/util/dateutil.dart';


class ScalpResultScreen extends StatefulWidget {
  ScalpResultScreen({required this.sculpKey});

  String sculpKey;
  Scalp? scalp;
  bool fetchCompleted = false;
  Map<String, dynamic>? currentData;
  String selectedScalpArea = ''; // New variable to track the selected sc

  @override
  _ScalpResultScreenState createState() => _ScalpResultScreenState();

}

class _ScalpResultScreenState extends State<ScalpResultScreen> {
  final ScalpRepository scalpRepository = ScalpRepository();

  @override
  void initState(){
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      print("check scalp status");
      scalpRepository.fetchDocument(widget.sculpKey).then((v) {
        setState(() {
          widget.scalp = Scalp.fromSnapshot(v);
          if(widget.currentData == null) {
            widget.currentData = widget.scalp!.top;
          }
          if(widget.scalp!.top != null &&
            widget.scalp!.back != null &&
              widget.scalp!.right != null &&
              widget.scalp!.left != null) {
            timer.cancel();
          }
        });
      });
    });
  }

  // Mapping from original key names to new names
  final Map<String, String> keyNameMapping = {
    'Type1': 'Dead skin',
    'Type2': 'Sebum',
    'Type3': 'Erythema',
    'Type4': 'Pustules',
    'Type5': 'Dandruff',
    'Type6': 'Hairloss',
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
                widget.currentData = scalp.top;
                widget.selectedScalpArea = 'top';
              }),
              child: Container(
                width: 70,
                height: 60,
                color: _getColorForCondition(scalp.top?['Condition'], widget.selectedScalpArea == 'top'),
              ),
            ),
          ),
          Positioned( // Back
            left: 119,
            top: 120,
            child: GestureDetector(
              onTap: () => setState(() {
                widget.currentData = scalp.back;
                widget.selectedScalpArea = 'back';
              }),
              child: Container(
                width: 70,
                height: 60,
                color: _getColorForCondition(scalp.back?['Condition'], widget.selectedScalpArea == 'back'),
              ),
            ),
          ),
          Positioned( // Left
            left: 50,
            top: 70,
            child: GestureDetector(
              onTap: () => setState(() {
                widget.currentData = scalp.left;
                widget.selectedScalpArea = 'left';
              }),
              child: Container(
                width: 60,
                height: 70,
                color: scalp.left == null ? Colors.grey :
                  _getColorForCondition(scalp.left?['Condition'], widget.selectedScalpArea == 'left'),
              ),
            ),
          ),
          Positioned( // Right
            left: 200,
            top: 70,
            child: GestureDetector(
              onTap: () => setState(() {
                widget.currentData = scalp.right;
                widget.selectedScalpArea = 'right';
              }),
              child: Container(
                width: 60,
                height: 70,
                color: _getColorForCondition(scalp.right?['Condition'], widget.selectedScalpArea == 'right'),
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
      case 'Inflammatory':
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
        backgroundColor: Color(0xFFEEEEEE),
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
      backgroundColor: Color(0xFFEEEEEE),

      body: (widget.scalp == null)
          ? Center( // Centering the CircularProgressIndicator
        child: CircularProgressIndicator(),
      )        : Column(
            children: <Widget>[
              // SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Your scalp condition is',
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
                        '${widget.currentData?['Condition'] ?? '정보 없음'}',
                        style: TextStyle(
                          color: Color(0xFF23262F),
                          fontSize: 26,
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
              widget.scalp != null ? scalpButton(widget.scalp!) : Container(),
              Padding(
                padding: EdgeInsets.only(left: 130), // Adjust the left padding as needed
                child: Row(
                  children: [
                    Text(
                      '0',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                    SizedBox(width: 65),
                    Text(
                      '1',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                    SizedBox(width: 65),
                    Text(
                      '2',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                    SizedBox(width: 65),
                    Text(
                      '3',
                      style: TextStyle(fontWeight: FontWeight.bold), // Add this line to make the text bold
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: widget.currentData != null
                    ? _buildProgressIndicators(widget.currentData)
                    : Text('원하는 부위를 누르세요'),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ScalpRecordScreen() )
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.green),
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all(Size(200, 50)), // Adjust the width and height as needed
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green), // Set the background color to light green
                  ),
                  child: Text(
                    "My records".toUpperCase(),
                    style: TextStyle(fontSize: 16,color :Colors.white), // You can adjust the font size here
                  ),
                ),
              ),
            ],
      ),
    );
  }

  Widget _buildButton(String title, Map<String, dynamic>? data) {
    return ElevatedButton(
      onPressed: () => setState(() {
        widget.currentData = data;
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





