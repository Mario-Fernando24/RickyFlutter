import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickmorty/data/characters_repository_impl.dart';
import 'package:rickmorty/domain/repositories/characters_repositoies.dart';

import '../../../constants/constants.dart';
import '../../../domain/models/characters.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  CharactersRepository characterRepository = CharactersRepositoryImpl();

  final StreamController<List<Character>> _characterController =
      StreamController<List<Character>>.broadcast();

  Stream<List<Character>> get characterController =>
      _characterController.stream;

  CharacterBloc() : super(CharacterInitial()) {
    on<CharacterEvent>((event, emit) {});
    on<SearchCharacterEvent>(_handleRgisterSearchText);
    on<FilterCharacterEvent>(_handleFilter);
  }

  void _handleRgisterSearchText(SearchCharacterEvent event, emit) async {
    try {
      emit(state.copyWith(loading: false));
      final character =
          await characterRepository.getCharacter(event.searchTerm);
      _characterController.add(character);
    } catch (error) {
      print(error.toString());
    }
  }

  void _handleFilter(FilterCharacterEvent event, emit) async {

     final List<Character> array=[];
    final character = await characterRepository.getCharacter("");

    //mayor a menor
    if (event.filter == "1") {
      character.sort((a, b) {
        return a.name.compareTo(b.name);
      });
      final reversed = character.reversed;
      _characterController.add(reversed.toList());
    }
    //menor a mayor
    if (event.filter == "2") {
      character.sort((a, b) {
        return a.name.compareTo(b.name);
      });
      _characterController.add(character);
    }
    //femenino
    if (event.filter == "3") {
     
      for (var element in character) {
        if (element.gender == AppConstants.Female) {
          array.add(element);
        }
      }
        _characterController.add(array.toList());
    }
    //masculino
    if (event.filter == "4") {
        for (var element in character) {
        if (element.gender == AppConstants.Male) {
          array.add(element);
        }
      }
        _characterController.add(array.toList());
    }
  }

  void getListCharacters() async {
    try {
      emit(CharacterLoading());
      final character = await characterRepository.getCharacter("");
      _characterController.add(character);
    } catch (error) {
      print(error.toString());
    }
  }

   void dispose() {
    _characterController.close();
  }
}
