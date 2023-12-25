import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:p4ds/models/scalp.dart';
import 'package:p4ds/repo/scalp_repository.dart'; // Import ScalpRepository


class ScalpCompareScreen extends StatefulWidget {
  List<String> checkedList;
  Scalp? beforeScalp;
  Scalp? afterScalp;
  String selectedScalpArea = ''; // New variable to track the selected scalp area
  Map<String, dynamic>? currentData;

  ScalpCompareScreen(this.checkedList);

  @override
  _ScalpCompareScreenState createState() => _ScalpCompareScreenState();
}

class _ScalpCompareScreenState extends State<ScalpCompareScreen> {
  final ScalpRepository scalpRepository = ScalpRepository();

  Future<String> _getImageUrl(String imagePath) async {
    String imageUrl = await FirebaseStorage.instance.ref(imagePath).getDownloadURL();
    return imageUrl;
  }

  Widget buildAreaImage(Scalp? scalp, String area, String label) {
    String? imagePath = _getDataForArea(scalp, area)?['image'];
    print('Image path for $area: $imagePath');

    return Expanded(
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // The label
          FutureBuilder(
            future: imagePath != null ? _getImageUrl(imagePath) : Future.value(''),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(10.0), // Padding around the image
                  child: Image.network(snapshot.data!),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Loading indicator
              } else {
                return Text('No image available for $area');
              }
            },
          ),
        ],
      ),
    );
  }




  Map<String, dynamic>? _getDataForArea(Scalp? scalp, String area) {
    switch(area) {
      case 'top':
        return scalp?.top;
      case 'back':
        return scalp?.back;
      case 'left':
        return scalp?.left;
      case 'right':
        return scalp?.right;
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    widget.checkedList.sort();
    print("fetch documents ${widget.checkedList[0]} ${widget.checkedList[1]}");
    scalpRepository.fetchDocument(widget.checkedList[0]).then((value) => setState(() => widget.beforeScalp = Scalp.fromSnapshot(value)));
    scalpRepository.fetchDocument(widget.checkedList[1]).then((value){
      setState(() {
        widget.afterScalp = Scalp.fromSnapshot(value);
        widget.currentData = widget.afterScalp!.top;
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
            child: Image.asset('assets/images/home/head.png',
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
                color: _getColorForCondition(scalp.left?['Condition'], widget.selectedScalpArea == 'left'),
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
              Navigator.pop(context);
            },
          ),
        ),
      ),
      backgroundColor: Color(0xFFEEEEEE),

      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Compare Before and After Conditions!',
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
            SizedBox(height: 20),
            widget.afterScalp != null
                ? Center(
              child: scalpButton(widget.afterScalp!),
            )
                : Container(),
            widget.selectedScalpArea.isNotEmpty
                ? Padding(
              padding: EdgeInsets.only(left: 130), // Adjust the left padding as needed
              child: Row(
                children: [
                  const Text('-3', style: TextStyle(fontWeight: FontWeight.bold)), // Add this line to make the text bold
                  SizedBox(width: 23),
                  const Text('-2', style: TextStyle(fontWeight: FontWeight.bold)), // Add this line to make the text bold
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
            )
                : SizedBox.shrink(), // Returns an empty container when no area is selected

            SizedBox(height: 10),
            widget.selectedScalpArea.isNotEmpty
                ? Center(
              child: SizedBox(
                height: 250, // Adjust this height as needed
                child: _buildProgressIndicators(
                    _getDataForArea(widget.afterScalp, widget.selectedScalpArea),
                    _getDataForArea(widget.beforeScalp, widget.selectedScalpArea)),
              ),
            )
                : Center(
              child: Text(
                'Press the area you want to check.',
                style: TextStyle(fontSize: 20),
              ),
            ),

            SizedBox(height: 10),
            SizedBox(height: 10),

            widget.selectedScalpArea.isNotEmpty ? Row(
              children: [
                buildAreaImage(widget.beforeScalp, widget.selectedScalpArea, "Before"),
                buildAreaImage(widget.afterScalp, widget.selectedScalpArea, "After"),
              ],
            ) : Text(
              '',
              style: TextStyle(fontSize: 20),
            ),

          ],
        ),
      )

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

  Widget _buildProgressIndicators(Map<String, dynamic>? afterData, Map<String, dynamic>? beforeData) {
    return ListView(
      physics: NeverScrollableScrollPhysics(), // Disable scrolling here
      children: afterData!.entries.where((entry) {
        // Exclude 'condition' and 'image' fields
        return entry.key != 'Condition' && entry.key != 'image';
      }).map((entry) {
        int afterValue = int.tryParse(entry.value.toString()) ?? 0; // Convert to int for 'after' data
        int beforeValue = int.tryParse(beforeData![entry.key].toString()) ?? 0; // Convert to int for 'before' data
        int difference = afterValue - beforeValue; // Calculate the difference

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
                  value: _normalize(difference),
                  backgroundColor: Colors.grey[300],
                  color: _getColorForDifference(difference),
                  minHeight: 8, // Adjust the height of the progress indicator as needed
                ),
              ),

            ],
          ),
        );
      }).toList(),
    );
  }

  double _normalize(int difference) {
    // Adjust the normalization logic based on the maximum possible difference
    int maxDifference = 3; // Example max difference (e.g., -3 to +3), adjust as necessary
    return (difference + maxDifference) / (2 * maxDifference); // Normalize between 0 and 1
  }

  Color _getColorForDifference(int difference) {
    // Return a color based on the difference
    if (difference < 0) {
      return Colors.green; // Positive difference
    } else if (difference > 0) {
      return Colors.red; // Negative difference
    } else {
      return Colors.grey; // No difference
    }
  }

}





