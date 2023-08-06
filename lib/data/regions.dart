import '../models/pokemon.dart';
import '../models/region.dart';

List<Region> groupPokemonsByRegion(List<Pokemon> pokemons) {
  return [
    Region(
      name: 'Kanto',
      pokemons: pokemons.where((p) => p.id >= 1 && p.id <= 151).toList(),
    ),
    Region(
      name: 'Johto',
      pokemons: pokemons.where((p) => p.id >= 152 && p.id <= 251).toList(),
    ),
    // Add more regions here if needed
  ];
}
