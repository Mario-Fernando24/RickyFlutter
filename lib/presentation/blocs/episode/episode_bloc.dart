import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickmorty/domain/models/episodes.dart';
import 'package:rickmorty/domain/repositories/episode_repositories.dart';

import '../../../data/episodes_repository_impl.dart';

part 'episode_event.dart';
part 'episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  EpisodesRepository episodesRepository = EpisodesRepositoryImpl();

  final StreamController<List<Episodes>> _episodeController =
      StreamController<List<Episodes>>.broadcast();

  Stream<List<Episodes>> get episodeController => _episodeController.stream;

  EpisodeBloc() : super(EpisodeInitial()) {
    on<EpisodeEvent>((event, emit) {});
    on<FilterEpisodesEvent>(_handleFilter);
    on<SearchEpisodesEvent>(_handleRgisterSearchText);
  }

  void _handleRgisterSearchText(SearchEpisodesEvent event, emit) async {
    try {
      emit(state.copyWith(loading: false));
      final episodess = await episodesRepository.getEpisode(event.searchTerm);
      _episodeController.add(episodess);
    } catch (error) {
      print(error.toString());
    }
  }

  void _handleFilter(FilterEpisodesEvent event, emit) async {
    final episode = await episodesRepository.getEpisode("");
    print(event.filter);
    //mayor a menor
    if (event.filter == "1") {
      episode.sort((a, b) {
        return a.name.compareTo(b.name);
      });
      final reversed = episode.reversed;
      _episodeController.add(reversed.toList());
    }
    //menor a mayor
    if (event.filter == "2") {
      episode.sort((a, b) {
        return a.name.compareTo(b.name);
      });
      _episodeController.add(episode);
    }
  }

  void getListEpisode() async {
    try {
      emit(EpisodeInitial());
      final episode = await episodesRepository.getEpisode("");
      _episodeController.add(episode);
    } catch (error) {
      print(error.toString());
    }
  }
}
