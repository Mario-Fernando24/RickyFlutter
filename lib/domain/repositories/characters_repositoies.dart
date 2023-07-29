
import 'package:rickmorty/domain/models/characters.dart';
import 'package:rickmorty/domain/models/episodes.dart';
import 'package:rickmorty/domain/models/location.dart';

abstract class CharactersRepository {
  
  Future<List<Character>> getCharacter(String data);

}
