part of 'character_bloc.dart';

 class CharacterState extends Equatable {
   final bool loading;
  final List<Character> characters;

  const CharacterState({this.loading = false, characters})
      : characters = characters ?? const [];

  CharacterState copyWith({
    bool? loading,
    List<Character>? characters,
  }) =>
      CharacterState(
          loading: loading ?? this.loading,
          characters: characters ?? this.characters);

  @override
  List<Object?> get props => [loading, characters];
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}

class CharacterSuccess extends CharacterState {
  final bool success;

  CharacterSuccess({required this.success});

  @override
  List<Object> get props => [success];
}
