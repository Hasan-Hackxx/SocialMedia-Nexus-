import 'package:flutter/material.dart';
import 'package:nexus/PostPage.dart';
import 'package:nexus/orders/postForamt.dart';
import 'package:nexus/supabase_service.dart/supabase_Storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final userId = Supabase.instance.client.auth.currentUser!.id;

class Favoritepage extends StatefulWidget {
  final List<Map<String, dynamic>> posts;

  const Favoritepage({super.key, required this.posts});

  @override
  State<Favoritepage> createState() => _FavoritepageState();
}

class _FavoritepageState extends State<Favoritepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 20),

      appBar: AppBar(
        title: const Text(
          'My Ideas',
          style: TextStyle(
            color: Color.fromARGB(255, 97, 97, 97),
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(0, 0, 0, 20),
      ),

      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: SupabaseStorage().getPost(userId),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                "No Ideas Yet",
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            );
          }

          final posts = snapshot.data!;

          return ListView.builder(
            itemCount: posts.length,

            itemBuilder: (context, index) {
              final post = posts[index];

              return Padding(
                padding: const EdgeInsets.all(14.0),

                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Postpage(post: post),
                    ),
                  ),

                  child: Postforamt(
                    postName: post['ideaName'],

                    onTap: () async {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Are you sure you want to delte this Post',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                                await SupabaseStorage().deletePost(post['id']);
                              },
                              child: Text(
                                'Yes',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),

                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'No',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
