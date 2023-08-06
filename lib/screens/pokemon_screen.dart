import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon.dart';

class PokemonScreen extends StatelessWidget {
  final Pokemon pokemon;

  PokemonScreen({Key? key, required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pokemon.name),
      ),
      body: Column(
        children: <Widget>[
          Image.network(pokemon.imageUrl),
          Text('ID: ${pokemon.id}'),
          Text('Name: ${pokemon.name}'),
        ],
      ),
    );
  }
}
