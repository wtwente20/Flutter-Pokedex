import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon.dart';

class AddPokemonScreen extends StatefulWidget {
  final List<Pokemon> allPokemons; // Change the type to List<Pokemon>

  AddPokemonScreen({required this.allPokemons});

  @override
  _AddPokemonScreenState createState() => _AddPokemonScreenState();
}

class _AddPokemonScreenState extends State<AddPokemonScreen> {
  List<Pokemon> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Pokemon to Party'),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              setState(() {
                searchResults = _searchPokemon(value, widget.allPokemons); // Use widget.allPokemons here
              });
            },
            decoration: InputDecoration(hintText: "Enter Pokemon name or ID"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final pokemon = searchResults[index];
                return ListTile(
                  title: Text(pokemon.name),
                  leading: Image.network(pokemon.imageUrl, height: 40, width: 40),
                  onTap: () {
                    Navigator.pop(context, pokemon); // Return the selected pokemon
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Pokemon> _searchPokemon(String searchTerm, List<Pokemon> allPokemons) {
    return allPokemons.where((pokemon) {
      return pokemon.name.toLowerCase().contains(searchTerm.toLowerCase()) ||
          pokemon.id.toString() == searchTerm;
    }).toList();
  }
}
