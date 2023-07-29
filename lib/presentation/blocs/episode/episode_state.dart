part of 'episode_bloc.dart';

 class EpisodeState extends Equatable {
  final bool loading;
  final List<Episodes> characters;

  const EpisodeState({this.loading = false, characters})
      : characters = characters ?? const [];

  EpisodeState copyWith({
    bool? loading,
    List<Episodes>? characters,
  }) =>
      EpisodeState(
          loading: loading ?? this.loading,
          characters: characters ?? this.characters);

  @override
  List<Object?> get props => [loading, characters];
}

class EpisodeInitial extends EpisodeState {}

class EpisodeLoading extends EpisodeState {}

class EpisodeSuccess extends EpisodeState {

  final bool success;
  EpisodeSuccess({required this.success});

  @override
  List<Object> get props => [success];
}


