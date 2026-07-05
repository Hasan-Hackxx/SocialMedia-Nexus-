import 'package:supabase_flutter/supabase_flutter.dart';

final userId = Supabase.instance.client.auth.currentUser!.id;

class SupabaseStorage {
  Future<int?> svaeMyPost(String post, String userId, String idea) async {
    final response = await Supabase.instance.client
        .from('Ideas')
        .insert({'post': post, 'userId': userId, 'ideaName': idea})
        .select()
        .single();

    return response['id'] as int?;
  }

  Future<void> deletePost(int id) async {
    await Supabase.instance.client.from('Ideas').delete().eq('id', id);
  }

  Stream<List<Map<String, dynamic>>> getPost(String userId) {
    return Supabase.instance.client
        .from('Ideas')
        .stream(primaryKey: ['id'])
        .order('id');
  }
}
