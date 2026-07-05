import 'package:flutter/material.dart';
import 'package:nexus/NexusSplashScreen.dart';
import 'package:nexus/getGate.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://mumpeogbdveexkrprymy.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im11bXBlb2diZHZlZXhrcnByeW15Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzc0MDU4MDUsImV4cCI6MjA5Mjk4MTgwNX0.ghphXUgX7O6OJcLjuUEsS-o6LO2H5NSQ0-Zv6y4uNm4',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Nexussplashscreen(),
    );
  }
}
