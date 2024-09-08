import 'package:country_flags/country_flags.dart';
import 'package:flashcards/data/flag.dart';
import 'package:flashcards/pages/details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final collectionsName = [];
  final languagesCode = languages.keys.toList(); // Lista kluczy
  final languagesName = languages.values.toList();
  final _collectionController = TextEditingController();
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
                return ListTile(
                  title: Text(collectionsName[index]),
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DetailsPage())),
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('New flashcards'),
                content: SizedBox(
                  width: double.maxFinite, // szerokość Dialogu
                  height: MediaQuery.sizeOf(context).height / 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _collectionController,
                        decoration: InputDecoration(
                            hintText: "Enter collection name",
                            border: OutlineInputBorder()),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Select language (optional)"),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: languagesName.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Flexible(
                                child: Row(
                                  children: [
                                    CountryFlag.fromLanguageCode(
                                        languagesCode[index]),

                                    Text("${languagesName[index]}"),
                                    // Spacer(),
                                  ],
                                ),
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
                    label: Text("Cancel"),
                    icon: Icon(Icons.cancel_outlined),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        collectionsName.add(_collectionController.text.trim());
                      });

                      Navigator.pop(context);
                    },
                    label: Text("Add"),
                    icon: Icon(Icons.add),
                    style: TextButton.styleFrom(foregroundColor: Colors.green),
                  )
                ],
              );
            },
          );
        },
        child: Icon(Icons.language),
      ),
    );
  }
}
