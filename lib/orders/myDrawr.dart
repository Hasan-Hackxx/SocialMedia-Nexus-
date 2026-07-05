import 'package:flutter/material.dart';
import 'package:nexus/FavoritePage.dart';
import 'package:nexus/auth_service.dart';
import 'package:nexus/loginorRegisterPage.dart';

class Mydrawr extends StatelessWidget {
  const Mydrawr({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 80, 79, 79),

      child: Align(
        alignment: .topCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Image.asset(
                      'assests/images/nexus.png',

                      width: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                ListTile(
                  onTap: () => Navigator.pop(context),
                  leading: Icon(Icons.home, color: Colors.black),
                  title: Text('H O M E'),
                ),

                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Favoritepage(posts: []),
                      ),
                    );
                  },
                  leading: Icon(Icons.favorite, color: Colors.black),
                  title: Text('F A V O  R I T E'),
                ),
              ],
            ),
            ListTile(
              onTap: () async {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Are you sure you want to logout form App...!'),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await AuthService().logout();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Loginorregisterpage(),
                            ),
                          );
                        },
                        child: Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('No'),
                      ),
                    ],
                  ),
                );
              },
              leading: Icon(Icons.logout, color: Colors.black),
              title: Text('L O G O U T'),
            ),
          ],
        ),
      ),
    );
  }
}
