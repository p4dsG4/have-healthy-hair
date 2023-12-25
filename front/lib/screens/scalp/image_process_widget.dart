

import 'package:flutter/material.dart';

class ImageProcessingWidget extends StatelessWidget {
  String imageUrl;
  bool showProgress;

  ImageProcessingWidget(this.imageUrl, this.showProgress, {super.key });

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Image.network(imageUrl, width: 100, height: 100),
          SizedBox(height: 15,),
          showProgress ? Container(
              width: 200,
              child:LinearProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              )
          ) : Container(),
        ]
    );
  }

}