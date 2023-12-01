import 'package:flutter/material.dart';
import 'package:p4ds/providers/main_provider.dart';
import 'package:p4ds/providers/user_provider.dart';
import 'package:p4ds/routes/index.dart';
import 'package:p4ds/screens/edit_profile_screen.dart';
import 'package:p4ds/screens/scalp/scalp_1.dart';
import 'package:p4ds/screens/scalp/scalp_2.dart';
import 'package:p4ds/screens/scalp/scalp_3.dart';
import 'package:p4ds/screens/scalp/scalp_4.dart';
import 'package:p4ds/screens/scalp/scalp_result.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized(); // Ensure that Flutter is initialized.

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
        // scalp screens
        Routes.scalp1: (context) => const Scalp1Screen(),
        Routes.scalp2: (context) => const Scalp2Screen(),
        Routes.scalp3: (context) => const Scalp3Screen(),
        Routes.scalp4: (context) => const Scalp4Screen(),
        Routes.scalpResult: (context) =>  ScalpResultScreen(),
      },
      initialRoute: Routes.mainScreen,
    );
  }
}

