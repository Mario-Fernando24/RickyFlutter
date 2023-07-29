import 'dart:convert';
import 'dart:ffi';

import 'package:rickmorty/constants/constants.dart';
import 'package:rickmorty/domain/models/characters.dart';
import 'package:rickmorty/domain/models/episodes.dart';
import 'package:rickmorty/domain/models/location.dart';
import 'package:rickmorty/domain/repositories/episode_repositories.dart';
import '../domain/repositories/characters_repositoies.dart';
import 'package:http/http.dart' as http;

class EpisodesRepositoryImpl implements EpisodesRepository {
  String url = AppConstants.API_URL;

  @override
  Future<List<Episodes>> getEpisode(String d) async {
    final http.Response response;

    if (d == "") {
      response = await http.get(Uri.parse('${url}episode'));
    } else {
      response = await http.get(Uri.parse('${url}episode/?name=${d}'));
    }

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> results = data['results'];
      return results
          .map((episodeJson) => Episodes.fromJson(episodeJson))
          .toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load episodes');
    }
  }
}
