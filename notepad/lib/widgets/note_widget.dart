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
  dynamic result;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        print('${now.year}-${now.month}-${now.day}');
        result= await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotePage(
              title: widget.title,
              description: widget.description,
            ),
          ),
        );
        print(result[0]);
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
        widget.title,//!=result[0]?result[0]:widget.title,
        maxLines: 1,
      ),
      subtitle: Text(
        widget.description,//!=result[1]?result[1]:widget.description,
        maxLines: 1,
        softWrap: true,
      ),
      tileColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    );
  }
}
