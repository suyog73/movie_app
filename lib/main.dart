import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/methods/get_user_data.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/provider/movie_detail_provider.dart';
import 'package:movie_app/screens/onboarding_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  User? user = FirebaseAuth.instance.currentUser;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => MovieDetailProvider()),
      ],
      child: MaterialApp(
        title: 'Movies App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: user != null ? const GetUserData() : const OnBoardingScreen(),
      ),
    );
  }
}
