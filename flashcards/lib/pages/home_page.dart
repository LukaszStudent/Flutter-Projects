import 'package:country_flags/country_flags.dart';
import 'package:flashcards/data/flag.dart';
import 'package:flashcards/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final collectionsName = [];
  late List<String> languagesName;
  late dynamic filteredLanguages;
  final _collectionController = TextEditingController();
  final _searchLanguageController = TextEditingController();

  void searchLanguage(String value) {
    final result = languages.entries.where((entry) =>
        entry.value.toLowerCase().trim().contains(value.toLowerCase().trim()));

    setState(() {
      filteredLanguages = result.toList();
    });
  }

  @override
  void initState() {
    super.initState();
    languagesName = languages.values.toList();
    filteredLanguages = languages.entries.toList();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _collectionController.dispose();
    _searchLanguageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlashCards'),
      ),
      body: collectionsName.isEmpty
          ? const Center(
              child: Text('Press the button to add new collection.'),
            )
          : ListView.builder(
              itemCount: collectionsName.length,
              itemBuilder: (context, index) {
                // final test = languages[index];
                return Dismissible(
                  key: Key(index.toString()),
                  background: const Card(
                    color: Colors.red,
                    child: Icon(
                      Icons.delete,
                    ),
                  ),
                  onDismissed: (direction) async {
                    setState(() {
                      collectionsName.removeAt(index);
                    });
                    await Hive.deleteBoxFromDisk(
                        _collectionController.text.trim());
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(collectionsName[index]),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsPage(
                            collectionName: collectionsName[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            // barrierDismissible: false,
            context: context,
            builder: (context) {
              _collectionController.clear();
              _searchLanguageController.clear();
              filteredLanguages = languages.entries.toList();
              return StatefulBuilder(builder: (context, setStateDialog) {
                return AlertDialog(
                  title: const Text('New flashcards'),
                  content: SizedBox(
                    width: double.maxFinite, // szerokość Dialogu
                    height: MediaQuery.sizeOf(context).height / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _collectionController,
                          decoration: const InputDecoration(
                              hintText: "Enter collection name",
                              border: OutlineInputBorder()),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                          child: TextFormField(
                            controller: _searchLanguageController,
                            onChanged: (value) => setStateDialog(() {
                              searchLanguage(value);
                            }),
                            decoration: const InputDecoration(
                                hintText: "Serach language (optional)",
                                border: OutlineInputBorder()),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ListView.builder(
                            itemCount: filteredLanguages.length,
                            itemBuilder: (context, index) {
                              // print(language);
                              return ListTile(
                                title: Row(
                                  children: [
                                    CountryFlag.fromLanguageCode(
                                        filteredLanguages[index].key),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Flexible(
                                        child: Text(
                                            filteredLanguages[index].value)),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
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
                      onPressed: () async {
                        setState(() {
                          collectionsName
                              .add(_collectionController.text.trim());
                        });
                        await Hive.openBox(_collectionController.text.trim());
                        Navigator.pop(context);
                      },
                      label: const Text("Add"),
                      icon: const Icon(Icons.add),
                      style:
                          TextButton.styleFrom(foregroundColor: Colors.green),
                    )
                  ],
                );
              });
            },
          );
        },
        child: const Icon(Icons.language),
      ),
    );
  }
}
