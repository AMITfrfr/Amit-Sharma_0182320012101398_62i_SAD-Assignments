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
      title: Text(widget.idea != null ? 'Edit Idea' : 'New Idea',
          style: TextStyle(color: darkPurple, fontWeight: FontWeight.bold, fontSize: 22)),
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
              final newIdea = Idea(title: title, description: description, category: category);
              widget.onSave(newIdea);
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

class _IdeaHomeScreenState extends State<IdeaHomeScreen> {
  List<Idea> ideas = [];
  final Random random = Random();

  List<Widget> generateDecorativeCircles(double width, double height, int count) {
    return List.generate(count, (_) {
      double size = 10 + random.nextInt(30).toDouble();
      return Positioned(
        left: random.nextDouble() * width,
        top: random.nextDouble() * height,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.15 + random.nextDouble() * 0.1),
          ),
        ),
      );
    });
  }

  void logout() {
    // Here you can implement your logout logic
    Navigator.pop(context); // example: just pop the screen
  }

  @override
  Widget build(BuildContext context) {
    final darkPurple = Colors.purple[400]!;
    final lightPurple = Colors.purple[100]!;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [lightPurple, Colors.purple[200]!], begin: Alignment.topLeft, end: Alignment.bottomRight),
        ),
        child: Stack(
          children: [
            ...generateDecorativeCircles(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height, 40),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
                        decoration: BoxDecoration(color: darkPurple, borderRadius: BorderRadius.circular(22)),
                        child: const Text("Your Ideas", style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
                      ),
                      ElevatedButton(
                        onPressed: logout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkPurple,
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 6,
                        ),
                        child: const Text("Logout", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ideas.isEmpty
                        ? const Center(child: Text("No ideas yet.", style: TextStyle(color: Colors.white, fontSize: 18)))
                        : ListView.builder(
                            itemCount: ideas.length,
                            itemBuilder: (context, index) {
                              final idea = ideas[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: darkPurple.withOpacity(0.85),
                                  borderRadius: BorderRadius.circular(16),
                                ),
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
                                              ideas.removeAt(index);
                                            });
                                          },
                                          child: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ),
                  const SizedBox(height: 20),
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
                    style: ElevatedButton.styleFrom(backgroundColor: darkPurple, padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
                    child: const Text("Add New Idea", style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
