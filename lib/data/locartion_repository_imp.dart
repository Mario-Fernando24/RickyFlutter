import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rickmorty/domain/models/location.dart';
import 'package:rickmorty/domain/repositories/location_repositories.dart';

import '../constants/constants.dart';

class LocationRepositoryImpl implements LocationRepository {
  String url = AppConstants.API_URL;

  @override
  Future<List<Location>> getLocation(String d) async {
    final http.Response response;

    if (d == "") {
      response = await http.get(Uri.parse('${url}location'));
    } else {
      response = await http.get(Uri.parse('${url}location/?name=${d}'));
    }

    final data = json.decode(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> results = data['results'];
      return results
          .map((locationJson) => Location.fromJson(locationJson))
          .toList();
    } else if (response.statusCode == 404) {
      return [];
    } else {
      throw Exception('Failed to load location');
    }
  }
}
