import 'package:flutter/material.dart';
import 'package:pokedex_app/models/pokemon.dart';
import 'package:pokedex_app/repositories/pokemon_repository.dart';
import 'package:pokedex_app/screens/add_pokemon_screen.dart';
import 'package:pokedex_app/screens/pokemon_screen.dart';
import 'package:pokedex_app/widgets/pokedex_drawer.dart';

import '../data/regions.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Pokemon>> futurePokemons;
  List<Pokemon> partyPokemons = [];

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
        leading: Builder(
          builder: (context) => IconButton(
            icon: Image.asset(
                'assets/images/287221.png'), // Path to your pokeball asset
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: FutureBuilder<List<Pokemon>>(
        future: futurePokemons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PokedexDrawer(
              allPokemons: snapshot.data!,
              partyPokemons: partyPokemons,
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Drawer(child: Center(child: CircularProgressIndicator()));
          } else {
            // You can add more specific handling based on error type or even allow retry
            return Drawer(child: Center(child: Text('Failed to load data')));
          }
        },
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
                              builder: (context) =>
                                  PokemonScreen(pokemon: pokemon),
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
            return Center(child: Text('${snapshot.error}'));
          }

          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () {
            _navigateToAddPokemonScreen(context);
          },
          child: Text('Add Pokemon to Party'),
        ),
      ),
    );
  }

  void _navigateToAddPokemonScreen(BuildContext context) async {
    final addedPokemon = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPokemonScreen(allPokemons: partyPokemons),
      ),
    );

    if (addedPokemon != null) {
      setState(() {
        partyPokemons.add(addedPokemon);
      });
    }
  }
}
