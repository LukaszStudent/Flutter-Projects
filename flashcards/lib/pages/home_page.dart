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
  final languagesCode = languages.keys.toList(); // Lista kluczy
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
                  onDismissed: (direction) {
                    setState(() {
                      collectionsName.removeAt(index);
                    });
                  },
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
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return StatefulBuilder(builder: (context, setState) {
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
                            onChanged: (value) => setState(() {
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
                                // onTap: () => setState(
                                //   () {
                                //     collectionsName.add(languagesName[index]);
                                //     // languagesName.removeAt(index);
                                //     // Navigator.pop(context);
                                //   },
                                // ),
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
                      onPressed: () {
                        setState(() {
                          collectionsName
                              .add(_collectionController.text.trim());
                        });
                        Hive.openBox(_collectionController.text.trim());
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
