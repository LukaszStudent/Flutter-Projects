import 'package:flutter/material.dart';
import 'package:notepad/pages/note.dart';

class MyNote extends StatefulWidget {
  final String title;
  final String description;
  const MyNote({super.key, required this.title, required this.description});

  @override
  State<MyNote> createState() => _MyNoteState();
}

class _MyNoteState extends State<MyNote> {
  bool isFavourite = false;
  DateTime now = DateTime.now();
  String? changedTitle;
  String? changedDescription;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        print('${now.year}-${now.month}-${now.day}');
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotePage(
              title: (changedTitle ?? widget.title),
              description: (changedDescription ?? widget.description),
            ),
          ),
        );
        if (result != null) {
          setState(() {
            changedTitle = result[0];
            changedDescription = result[1];
          });
        }
      },
      trailing: IconButton(
          onPressed: () {
            isFavourite = !isFavourite;
            setState(() {});
          },
          icon: Icon(
            Icons.star,
            color: isFavourite ? Colors.amber : Colors.white,
          )),
      title: Text(
        widget.title != (changedTitle ?? widget.title)
            ? (changedTitle ?? widget.title)
            : widget.title,
        maxLines: 1,
      ),
      subtitle: Text(
        widget.description != (changedDescription ?? widget.description)
            ? (changedDescription ?? widget.description)
            : widget.description,
        maxLines: 1,
        softWrap: true,
      ),
    );
  }
}
