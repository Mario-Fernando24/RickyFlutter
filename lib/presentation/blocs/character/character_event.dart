part of 'character_bloc.dart';

 class CharacterEvent extends Equatable {
  const CharacterEvent();

  @override
  List<Object> get props => [];
}

class GetAllCharacter extends CharacterEvent {
  final List<Character> character;

  const GetAllCharacter(this.character);
}

class SearchCharacterEvent extends CharacterEvent {
  final String searchTerm;

  SearchCharacterEvent(this.searchTerm);

  @override
  List<Object?> get prop => [searchTerm];
}



class FilterCharacterEvent extends CharacterEvent {
  final String filter;

  FilterCharacterEvent(this.filter);

  @override
  List<Object?> get prop => [filter];
}




