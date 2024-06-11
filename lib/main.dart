import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RandomPokemonPage(),
    );
  }
}

class RandomPokemonPage extends StatefulWidget {
  const RandomPokemonPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RandomPokemonPageState createState() => _RandomPokemonPageState();
}

class _RandomPokemonPageState extends State<RandomPokemonPage> {
  String? _pokemonName;
  String? _pokemonImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchRandomPokemon();
  }

  Future<void> _fetchRandomPokemon() async {
    final randomId = Random().nextInt(898) + 1; // Hay 898 Pokémon en la PokeAPI
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$randomId'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        _pokemonName = data['name'];
        _pokemonImageUrl = data['sprites']['front_default'];
      });
    } else {
      // Manejo de errores
      setState(() {
        _pokemonName = 'Error al obtener Pokémon';
        _pokemonImageUrl = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Aleatorio'),
      ),
      body: Center(
        child: _pokemonName == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _pokemonImageUrl != null
                      ? Image.network(_pokemonImageUrl!)
                      : Container(),
                  const SizedBox(height: 20),
                  Text(
                    _pokemonName!.toUpperCase(),
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _fetchRandomPokemon,
                    child: const Text('Obtener otro Pokémon'),
                  ),
                ],
              ),
      ),
    );
  }
}
