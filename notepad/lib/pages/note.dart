import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  final String title;
  final String description;
  const NotePage({super.key, required this.title, required this.description});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  bool isChangedDes = false;
  bool isChangedTitle = false;

  void _onChangedTitle(String newValue) {
    if (newValue != widget.title) {
      isChangedTitle = true;
    } else {
      isChangedTitle = false;
    }
    setState(() {});
  }

  void _onChangedDes(String newValue) {
    if (newValue != widget.description) {
      isChangedDes = true;
    } else {
      isChangedDes = false;
    }
    setState(() {});
  }

  @override
  void initState() {
    _titleController.text = widget.title;
    _descriptionController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){
            Navigator.pop(context,[_titleController.text,_descriptionController.text]);
          }, icon: Icon(Icons.arrow_back)),
          title: const Text('Note Details'),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Edit title',
                  style: TextStyle(fontSize: 20),
                ),
                TextField(
                  readOnly: false,
                  controller: _titleController,
                  onChanged: (val) => _onChangedTitle(val),
                  decoration: InputDecoration(
                    suffixIcon: isChangedTitle
                        ? const Icon(Icons.verified)
                        : const Icon(
                            Icons.edit,
                          ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Edit description',
                  style: TextStyle(fontSize: 20),
                ),
                TextField(
                  controller: _descriptionController,
                  onChanged: (val) => _onChangedDes(val),
                  maxLines: null,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                    onPressed: () {},
                    icon: isChangedDes
                        ? const Icon(Icons.verified)
                        : const Icon(
                            Icons.edit_note,
                          ),
                  )),
                ),
              ],
            ),
          ),
        ));
  }
}
