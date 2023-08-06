import 'package:pokedex_app/models/pokemon.dart';

class Region {
  final String name;
  final List<Pokemon> pokemons;

  Region({required this.name, required this.pokemons});
}
