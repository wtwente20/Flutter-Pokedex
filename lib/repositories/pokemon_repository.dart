import 'package:pokedex_app/data/pokemon_data.dart';
import 'package:pokedex_app/models/pokemon.dart';

class PokemonRepository {
  Future<List<Pokemon>> fetchPokemons() async {
    return pokemonData.map((pokemon) => Pokemon.fromJson(pokemon)).toList();
  }
}

