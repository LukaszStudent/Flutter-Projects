import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DetailsPage extends StatefulWidget {
  final String collectionName;
  const DetailsPage({super.key, required this.collectionName});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final List<MapEntry> words = [];
  final _oryginalWordController = TextEditingController();
  final _translatedWordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Hive.openBox(widget.collectionName).then((box) {
      setState(() {
        words.addAll(box.toMap().entries);
      });
    });
  }

  void addWord(String oryginalWord, String translatedWord) {
    var box = Hive.box(widget.collectionName);
    box.put(oryginalWord, translatedWord);
  }

  void removeWord(String oryginalWord) {
    var box = Hive.box(widget.collectionName);
    box.delete(oryginalWord);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.collectionName,
        ),
        centerTitle: true,
      ),
      body: words.isEmpty
          ? const Center(
              child: Text("Add words to your collection"),
            )
          : ListView.builder(
              itemCount: words.length,
              itemBuilder: (context, index) {
                final wordPair = words[index];
                return Dismissible(
                  key: const Key("klucz"),
                  onDismissed: (direction) {
                    setState(() {
                      words.removeAt(index);
                      removeWord(wordPair.key);
                    });
                  },
                  background: const Card(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text(wordPair.key),
                      subtitle: Text(wordPair.value),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Edit word"),
                                  actionsAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  actions: [
                                    TextButton.icon(
                                      onPressed: () => Navigator.pop(context),
                                      label: const Text("Cancel"),
                                      icon: const Icon(Icons.cancel_outlined),
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.red),
                                    ),
                                    TextButton.icon(
                                      onPressed: () => Navigator.pop(context),
                                      label: const Text("Save"),
                                      icon: const Icon(Icons.cancel_outlined),
                                      style: TextButton.styleFrom(
                                          foregroundColor: Colors.green),
                                    ),
                                  ],
                                );
                              });
                        },
                        icon: const Icon(Icons.edit),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewWordToCollection(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<dynamic> addNewWordToCollection(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add new word"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _oryginalWordController,
                decoration: const InputDecoration(
                    hintText: "Enter oryginal word",
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _translatedWordController,
                decoration: const InputDecoration(
                    hintText: "Enter translated word",
                    border: OutlineInputBorder()),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.pop(context),
              label: const Text("Cancel"),
              icon: const Icon(Icons.cancel_outlined),
              style: TextButton.styleFrom(foregroundColor: Colors.red),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  addWord(_oryginalWordController.text.trim(),
                      _translatedWordController.text.trim());
                  words.add(MapEntry(
                    _oryginalWordController.text.trim(),
                    _translatedWordController.text.trim(),
                  ));
                });
                Navigator.pop(context);
              },
              label: const Text("Add"),
              icon: const Icon(Icons.add),
              style: TextButton.styleFrom(foregroundColor: Colors.green),
            )
          ],
        );
      },
    );
  }
}
