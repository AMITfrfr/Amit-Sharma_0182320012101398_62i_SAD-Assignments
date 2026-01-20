import 'dart:math';
import 'package:flutter/material.dart';

class Idea {
  String title;
  String description;
  String category;

  Idea({required this.title, required this.description, this.category = ''});
}

class IdeaDialog extends StatefulWidget {
  final Idea? idea;
  final Function(Idea) onSave;
  const IdeaDialog({super.key, this.idea, required this.onSave});

  @override
  _IdeaDialogState createState() => _IdeaDialogState();
}

class _IdeaDialogState extends State<IdeaDialog> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String category = '';

  @override
  void initState() {
    super.initState();
    if (widget.idea != null) {
      title = widget.idea!.title;
      description = widget.idea!.description;
      category = widget.idea!.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkPurple = Colors.purple[400]!;
    final lightGray = Colors.grey[100]!;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      title: Text(
        widget.idea != null ? 'Edit Idea' : 'New Idea',
        style: TextStyle(color: darkPurple, fontWeight: FontWeight.bold, fontSize: 22),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(
                  labelText: "Title",
                  hintText: "Enter idea title",
                  filled: true,
                  fillColor: lightGray,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: darkPurple, width: 2)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                validator: (val) => val == null || val.isEmpty ? "Title required" : null,
                onSaved: (val) => title = val!.trim(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: description,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Enter idea description",
                  filled: true,
                  fillColor: lightGray,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: darkPurple, width: 2)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                validator: (val) => val == null || val.isEmpty ? "Description required" : null,
                onSaved: (val) => description = val!.trim(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: category,
                decoration: InputDecoration(
                  labelText: "Category",
                  hintText: "Optional",
                  filled: true,
                  fillColor: lightGray,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: darkPurple, width: 2)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                ),
                onSaved: (val) => category = val!.trim(),
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: darkPurple, textStyle: const TextStyle(fontWeight: FontWeight.bold)),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.onSave(Idea(title: title, description: description, category: category));
              Navigator.pop(context);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: darkPurple,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 6,
          ),
          child: Text(widget.idea != null ? "Update" : "Add", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

class IdeaHomeScreen extends StatefulWidget {
  const IdeaHomeScreen({super.key});

  @override
  State<IdeaHomeScreen> createState() => _IdeaHomeScreenState();
}

class _IdeaHomeScreenState extends State<IdeaHomeScreen> with SingleTickerProviderStateMixin {
  List<Idea> ideas = [];
  final Random random = Random();
  String selectedCategory = "All";
  late AnimationController menuAnimController;

  @override
  void initState() {
    super.initState();
    menuAnimController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() {
    menuAnimController.dispose();
    super.dispose();
  }

  List<Widget> generateCircles(double width, double height, int count) {
    return List.generate(count, (_) {
      double size = 20 + random.nextInt(60).toDouble();
      return Positioned(
        left: random.nextDouble() * width,
        top: random.nextDouble() * height,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), shape: BoxShape.circle),
        ),
      );
    });
  }

  void openCreativeMenu() {
    menuAnimController.forward().then((_) => menuAnimController.reverse());
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) => _CreativeSheet(
        onSelect: (category) {
          setState(() => selectedCategory = category);
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkPurple = Colors.purple[400]!;
    final lightPurple = Colors.purple[100]!;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final filteredIdeas = selectedCategory == "All"
        ? ideas
        : ideas.where((i) => i.category == selectedCategory).toList();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [lightPurple, Colors.purple[200]!], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Stack(
          children: [
            ...generateCircles(screenWidth, screenHeight, 30),

            // Creative Interests button
            Positioned(
              top: 40,
              left: 40,
              child: ScaleTransition(
                scale: Tween(begin: 1.0, end: 0.9).animate(menuAnimController),
                child: ElevatedButton(
                  onPressed: openCreativeMenu,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: darkPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                    elevation: 8,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(width: 8, height: 8, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
                      const SizedBox(width: 8),
                      const Text("Creative Interests"),
                    ],
                  ),
                ),
              ),
            ),

            // Logout button at top-right inside a rounded box
            Positioned(
              top: 40,
              right: 40,
              child: ElevatedButton(
                onPressed: () {
                  // Add your logout logic here
                  print("Logout pressed");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Light background
                  foregroundColor: darkPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  elevation: 6,
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),

            // Main content
            Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                      decoration: BoxDecoration(color: darkPurple, borderRadius: BorderRadius.circular(22)),
                      child: Text(selectedCategory == "All" ? "Your Ideas" : "$selectedCategory Ideas", style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(height: 20),
                    ...filteredIdeas.map((idea) {
                      return Stack(
                        children: [
                          ...generateCircles(260, 120, 5),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            width: 260,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(color: darkPurple.withOpacity(0.85), borderRadius: BorderRadius.circular(16)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(idea.title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(height: 6),
                                Text(idea.description, style: const TextStyle(color: Colors.white70)),
                                if (idea.category.isNotEmpty)
                                  Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                                    child: Text(idea.category, style: const TextStyle(color: Colors.white)),
                                  ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => IdeaDialog(
                                            idea: idea,
                                            onSave: (updatedIdea) {
                                              setState(() {
                                                int index = ideas.indexOf(idea);
                                                ideas[index] = updatedIdea;
                                              });
                                            },
                                          ),
                                        );
                                      },
                                      child: const Text("Edit", style: TextStyle(color: Colors.white)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          ideas.remove(idea);
                                        });
                                      },
                                      child: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                    const SizedBox(height: 20),
                    Stack(
                      children: [
                        ...generateCircles(260, 60, 5),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => IdeaDialog(
                                onSave: (newIdea) {
                                  setState(() {
                                    ideas.add(newIdea);
                                  });
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: darkPurple,
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                          ),
                          child: const Text("Add New Idea", style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CreativeSheet extends StatelessWidget {
  final Function(String) onSelect;
  const _CreativeSheet({required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _item("All", Colors.grey),
          _item("Songs", Colors.purple),
          _item("Literature", Colors.blue),
          _item("Business", Colors.green),
        ],
      ),
    );
  }

  Widget _item(String label, Color color) {
    return ListTile(
      leading: Container(width: 12, height: 12, decoration: BoxDecoration(shape: BoxShape.circle, color: color)),
      title: Text(label, style: const TextStyle(fontSize: 18)),
      onTap: () => onSelect(label),
    );
  }
}
