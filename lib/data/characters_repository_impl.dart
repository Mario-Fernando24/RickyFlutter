import 'dart:convert';
import 'dart:ffi';

import 'package:rickmorty/constants/constants.dart';
import 'package:rickmorty/domain/models/characters.dart';
import 'package:rickmorty/domain/models/episodes.dart';
import 'package:rickmorty/domain/models/location.dart';
import '../domain/repositories/characters_repositoies.dart';
import 'package:http/http.dart' as http;

class CharactersRepositoryImpl implements CharactersRepository {
  String url = AppConstants.API_URL;

  @override
  Future<List<Character>> getCharacter(String d) async {
    final http.Response response;

    if (d == "") {
      response = await http.get(Uri.parse('${url}character'));
    } else {
      response = await http.get(Uri.parse('${url}character/?name=${d}'));
    }

    final data = json.decode(response.body);
    final List<Character> characters = [];

    if (response.statusCode == 200) {
      for (var character in data['results']) {
        
        characters.add(Character.fromJson(character));
      }
      return characters;
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load characters');
    }
  }
}
