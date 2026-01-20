import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class IdeaProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;
  List<Map<String, dynamic>> _ideas = [];

  List<Map<String, dynamic>> get ideas => _ideas;

  
  Future<void> fetchIdeas() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      final data = await supabase
          .from('ideas')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      
      _ideas = (data as List<dynamic>).map((e) => e as Map<String, dynamic>).toList();
      notifyListeners();
    } catch (e) {
      print("Fetch Error: $e");
    }
  }

  
  Future<void> addIdea(String title, String description, String category) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      await supabase.from('ideas').insert({
        'title': title,
        'description': description,
        'category': category,
        'user_id': user.id,
      });

      await fetchIdeas(); 
    } catch (e) {
      print("Add Error: $e");
    }
  }

  
  Future<void> updateIdea(String id, String title, String description, String category) async {
    try {
      await supabase.from('ideas').update({
        'title': title,
        'description': description,
        'category': category,
      }).eq('id', id);

      await fetchIdeas(); 
    } catch (e) {
      print("Update Error: $e");
    }
  }

  
  Future<void> deleteIdea(String id) async {
    try {
      await supabase.from('ideas').delete().eq('id', id);

      await fetchIdeas(); 
    } catch (e) {
      print("Delete Error: $e");
    }
  }
}
