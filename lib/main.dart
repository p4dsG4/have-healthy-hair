import 'package:flutter/material.dart';
import 'package:p4ds/providers/main_provider.dart';
import 'package:p4ds/providers/user_provider.dart';
import 'package:p4ds/routes/index.dart';
import 'package:p4ds/screens/edit_profile_screen.dart';
import 'package:p4ds/screens/main_screen.dart';
import 'package:p4ds/screens/main_screens/hairline_screens.dart';
import 'package:p4ds/screens/main_screens/home_screen.dart';
import 'package:p4ds/screens/main_screens/scalp_screen.dart';
import 'package:p4ds/screens/main_screens/solutions_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: MainProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'P4DS',
      theme: ThemeData(),
      routes: {
        // Main
        Routes.mainScreen: (context) => const MainScreen(),
        Routes.homesScreen: (context) => const HomeScreen(),
        Routes.scalpScreen: (context) => const ScalpScreen(),
        Routes.solutionsScreen: (context) => const SolutionsScreen(),
        Routes.hairlineScreen: (context) => const HairlineScreen(),

        // Profile
        Routes.editProfileScreen: (context) => const EditScreenProfile(),
      },
      initialRoute: Routes.mainScreen,
    );
  }
}
