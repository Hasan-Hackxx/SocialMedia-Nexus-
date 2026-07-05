import 'package:flutter/material.dart';

class Postforamt extends StatelessWidget {
  final String postName;
  final void Function()? onTap;
  const Postforamt({super.key, required this.postName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 236, 72, 7),

        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 236, 72, 7),
            blurRadius: 15,
            spreadRadius: 1,
          ),
        ],
      ),

      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.feed),
            SizedBox(width: 13),
            Expanded(
              child: Text(
                postName,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(onPressed: onTap, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
