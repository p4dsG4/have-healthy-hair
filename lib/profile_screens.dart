import 'package:flutter/material.dart';
import 'package:p4ds/providers/main_provider.dart';
import 'package:p4ds/providers/user_provider.dart';
import 'package:p4ds/routes/index.dart';
import 'package:p4ds/screens/Profile/scalp_records.dart';
import 'package:p4ds/screens/edit_profile_screen.dart';
import 'package:p4ds/screens/solution/survey_1.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:p4ds/screens/Profile/profile.dart';
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
        Routes.scalpRecords: (context) => const ScalpRecordsScreen(),
        Routes.profile: (context) => const Profile(),


      },
      initialRoute: Routes.mainScreen,
    );
  }
}

