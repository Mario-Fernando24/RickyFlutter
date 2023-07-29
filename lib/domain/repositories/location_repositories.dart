

import 'package:rickmorty/domain/models/location.dart';

abstract class LocationRepository {
  Future<List<Location>> getLocation(String data);
}
