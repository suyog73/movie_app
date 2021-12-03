import 'package:flutter/material.dart';
import 'package:movie_app/provider/movie_provider.dart';
import 'package:movie_app/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Movies App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const HomePage(),
      ),
    );
  }
}
