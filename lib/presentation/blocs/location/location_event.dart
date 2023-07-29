part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class GetAllLocation extends LocationEvent {
  final List<Location> episodes;

  const GetAllLocation(this.episodes);
}

class SearchLocationEvent extends LocationEvent {
  final String searchTerm;

  SearchLocationEvent(this.searchTerm);

  @override
  List<Object?> get prop => [searchTerm];
}



class FilterLocationEvent extends LocationEvent {
  final String filter;

  FilterLocationEvent(this.filter);

  @override
  List<Object?> get prop => [filter];
}
