import 'package:flutter/material.dart';

import '../models/pokemon.dart';

class PokedexDrawer extends StatefulWidget {
  final List<Pokemon> allPokemons;
  final List<Pokemon> partyPokemons; // Add partyPokemons

  PokedexDrawer({required this.allPokemons, required this.partyPokemons}); // Add partyPokemons to the constructor

  @override
  _PokedexDrawerState createState() => _PokedexDrawerState();
}

class _PokedexDrawerState extends State<PokedexDrawer> {
  late TextEditingController searchController;
  List<Pokemon> filteredPokemons = []; // Create a list to filter the search results

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Pokemon> searchPokemon(String searchTerm) {
    return widget.allPokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
          pokemon.id.toString() == searchTerm;
    }).toList();
  }

  Future<void> _displaySearchDialog(BuildContext context) async {
    String? searchTerm;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Search Pokemon'),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.7,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          searchTerm = value;
                          filteredPokemons = searchPokemon(searchTerm!);
                        });
                      },
                      decoration: InputDecoration(hintText: "Enter Pokemon name or ID"),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        itemCount: filteredPokemons.length,
                        itemBuilder: (context, index) {
                          final pokemon = filteredPokemons[index];
                          return ListTile(
                            title: Text(pokemon.name),
                            leading: Image.network(pokemon.imageUrl, height: 40, width: 40),
                            onTap: () {
                              if (widget.partyPokemons.length < 6) { // Use widget.partyPokemons here
                                setState(() {
                                  widget.partyPokemons.add(pokemon); // Use widget.partyPokemons here
                                });
                                Navigator.of(context).pop();
                              } else {
                                // Handle party is full case
                                // Show a snackbar or another dialog
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: [
          const ListTile(
            title: Text('Your Party'),
          ),
          ...widget.partyPokemons.map((pokemon) => ListTile( // Use widget.partyPokemons here
            title: Text(pokemon.name),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.partyPokemons.remove(pokemon); // Use widget.partyPokemons here
                });
              },
            ),
          )),
          if (widget.partyPokemons.length < 6) // Use widget.partyPokemons here
            ElevatedButton(
              onPressed: () {
                _displaySearchDialog(context);
              },
              child: Text('Add Pokemon to Party'),
            ),
        ],
      ),
    );
  }
}
