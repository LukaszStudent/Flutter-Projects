import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
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
  final _mybox = Hive.box('myNote');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'All your notes in one place',
              style: TextStyle(fontSize: 26),
            ),
            Text('Number of notes: ${_mybox.length}',
                style: const TextStyle(fontSize: 22)),
            const SizedBox(
              height: 15,
            ),
            allnotes(),
          ],
        ),
      ),
    );
  }

  ListView allnotes() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _mybox.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) {
                    _mybox.delete(index);
                    setState(() {});
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: BorderRadius.circular(15),
                ),
              ],
            ),
            child: MyNote(
                title: _mybox.get(index)[0], description: _mybox.get(index)[1]),
          ),
        );
      },
    );
  }

  void addNote(String title, String description) {
    _mybox.add([title, description]);
  }

  AppBar appBar() {
    bool noTitle = false;
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
                    content: SizedBox(
                      height: 220,
                      child: Column(
                        children: [
                          const Divider(color: Colors.black, thickness: 1),
                          const Text('Add title'),
                          TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                                helperText: noTitle ? 'Fill in a title' : '',
                                helperStyle:
                                    TextStyle(decorationColor: Colors.red)),
                          ),
                          const SizedBox(
                            height: 28,
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
                            _titleController.clear();
                            _descriptionController.clear();
                          },
                          icon: const Icon(Icons.cancel),
                          label: const Text('CANCEL'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white)),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_titleController.text.trim().isNotEmpty) {
                            notes.add(Note(
                                title: _titleController.text,
                                description: _descriptionController.text));
                            Navigator.pop(context);
                            addNote(_titleController.text,
                                _descriptionController.text);

                            _titleController.clear();
                            _descriptionController.clear();
                          } else {
                            noTitle = true;
                          }

                          setState(() {});
                        },
                        icon: const Icon(Icons.verified),
                        label: const Text('OK'),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white),
                      ),
                    ],
                  );
                });
          },
          icon: const Icon(Icons.add),
          style: IconButton.styleFrom(backgroundColor: Colors.grey[100]),
        )
      ],
    );
  }
}
