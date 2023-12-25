import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final Function() onBackButtonPressed;
  final Function() onLogoTap; // Add this function for logo tap

  CustomAppBar({
    required this.onBackButtonPressed,
    required this.onLogoTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 20),
          child: IconButton(
            icon: const Icon(Icons.account_circle_rounded, size: 48, color: Colors.grey),
            onPressed: () {},
          ),
        ),
      ],
      toolbarHeight: 70,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      shadowColor: Colors.transparent,
      title: GestureDetector(
        onTap: onLogoTap, // Use the provided onLogoTap function
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Container(
            width: 60,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
