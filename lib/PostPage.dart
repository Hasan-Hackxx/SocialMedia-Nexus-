import 'package:flutter/material.dart';

class Postpage extends StatefulWidget {
  final Map<String, dynamic> post;
  const Postpage({super.key, required this.post});

  @override
  State<Postpage> createState() => _PostpageState();
}

class _PostpageState extends State<Postpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, 20),
      appBar: AppBar(
        title: Text(
          'Post',
          style: TextStyle(
            color: Color.fromARGB(255, 97, 97, 97),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 0, 0, 20),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: widget.post['post'] != ''
              ? Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 56, 56, 56),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 236, 72, 7),
                        blurRadius: 15,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.post['post'],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                        color: const Color.fromARGB(255, 161, 161, 161),
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ),
      ),
    );
  }
}
