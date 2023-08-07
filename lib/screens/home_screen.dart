import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon.dart';
import 'package:pokedex_app/repositories/pokemon_repository.dart';
import 'package:pokedex_app/screens/pokemon_screen.dart';

import '../data/regions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Pokemon>> futurePokemons;

  @override
  void initState() {
    super.initState();
    futurePokemons = PokemonRepository().fetchPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
      ),
      body: FutureBuilder<List<Pokemon>>(
  future: futurePokemons,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final regions = groupPokemonsByRegion(snapshot.data!);

      return ListView.builder(
        itemCount: regions.length,
        itemBuilder: (context, regionIndex) {
          final region = regions[regionIndex];
          return ExpansionTile(
            title: Text(region.name),
            children: region.pokemons.map((pokemon) {
              final theme = Theme.of(context);
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: theme.cardTheme.color,
                    onPrimary: theme.colorScheme.onPrimary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: theme.colorScheme.primary, width: 1.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PokemonScreen(pokemon: pokemon),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        '${pokemon.id}. ${pokemon.name}',
                        style: TextStyle(
                          color: theme.colorScheme.onBackground,
                        ),
                      ),
                      Spacer(),
                      Image.network(
                        pokemon.imageUrl,
                        height: 50,
                        width: 50,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      );
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }

    // By default, show a loading spinner.
    return CircularProgressIndicator();
  },
),

    );
  }
}
