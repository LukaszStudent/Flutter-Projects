import 'package:flutter/material.dart';
import 'package:notepad/widgets/note_widget.dart';

import '../models/note_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            SizedBox(height: 20,),
            Text(
              'Your notes. All here',style: TextStyle(fontSize: 26),
            ),
            SizedBox(height: 15,),
            ListView.builder(
                shrinkWrap: true,
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return MyNote(
                      title: notes[index].title,
                      description: notes[index].description);
                })
          ],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: const Text('NotePad'),
      centerTitle: true,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0.0,
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('New Note'),
                    content: Container(
                      height: 200,
                      child: Column(
                        children: [
                          const Divider(color: Colors.black, thickness: 1),
                          const Text('Add title'),
                          TextField(
                            controller: _titleController,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text('Add description'),
                          TextField(
                            controller: _descriptionController,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.cancel),
                          label: const Text('CANCEL'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red)),
                      ElevatedButton.icon(
                        onPressed: () {
                          notes.add(Note(
                              title: _titleController.text,
                              description: _descriptionController.text));
                          Navigator.pop(context);
                          setState(() {});
                        },
                        icon: const Icon(Icons.verified),
                        label: const Text('OK'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                      ),
                    ],
                  );
                });
          },
          icon: const Icon(Icons.add),
          style: IconButton.styleFrom(backgroundColor: Colors.grey),
        )
      ],
    );
  }
}
