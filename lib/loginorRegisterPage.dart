import 'package:flutter/material.dart';
import 'package:nexus/loginPage.dart';
import 'package:nexus/registerPage.dart';

class Loginorregisterpage extends StatefulWidget {
  const Loginorregisterpage({super.key});

  @override
  State<Loginorregisterpage> createState() => _LoginorregisterpageState();
}

class _LoginorregisterpageState extends State<Loginorregisterpage> {
  bool switchPage = true;

  void togglePage() {
    setState(() {
      switchPage = !switchPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (switchPage) {
      return Loginpage(onTap: togglePage);
    } else {
      return Registerpage(onTap: togglePage);
    }
  }
}
