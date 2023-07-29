part of 'episode_bloc.dart';

abstract class EpisodeEvent extends Equatable {
  const EpisodeEvent();

  @override
  List<Object> get props => [];
}

class GetAllEpisodes extends EpisodeEvent {
  final List<Episodes> episodes;

  const GetAllEpisodes(this.episodes);
}

class SearchEpisodesEvent extends EpisodeEvent {
  final String searchTerm;

  SearchEpisodesEvent(this.searchTerm);

  @override
  List<Object?> get prop => [searchTerm];
}



class FilterEpisodesEvent extends EpisodeEvent {
  final String filter;

  FilterEpisodesEvent(this.filter);

  @override
  List<Object?> get prop => [filter];
}
