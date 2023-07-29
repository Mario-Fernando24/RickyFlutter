import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rickmorty/data/locartion_repository_imp.dart';
import 'package:rickmorty/domain/models/location.dart';
import 'package:rickmorty/domain/repositories/location_repositories.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationRepository locationRepository = LocationRepositoryImpl();

  final StreamController<List<Location>> _locationController =
      StreamController<List<Location>>.broadcast();

  Stream<List<Location>> get locationController => _locationController.stream;

  LocationBloc() : super(LocationInitial()) {
    on<LocationEvent>((event, emit) {});
    on<SearchLocationEvent>(_handleRgisterSearchText);
    on<FilterLocationEvent>(_handleFilter);
  }

  void _handleRgisterSearchText(SearchLocationEvent event, emit) async {
    try {
      final episodess = await locationRepository.getLocation(event.searchTerm);
      _locationController.add(episodess);
    } catch (error) {
      print(error.toString());
    }
  }

  void _handleFilter(FilterLocationEvent event, emit) async {
    final locations = await locationRepository.getLocation("");
    print(event.filter);
    //mayor a menor
    if (event.filter == "1") {
      locations.sort((a, b) {
        return a.name.compareTo(b.name);
      });
      final reversed = locations.reversed;
      _locationController.add(reversed.toList());
    }
    //menor a mayor
    if (event.filter == "2") {
      locations.sort((a, b) {
        return a.name.compareTo(b.name);
      });
      _locationController.add(locations);
    }
  }

  void getListLocation() async {
    try {
      final location = await locationRepository.getLocation("");
      _locationController.add(location);
    } catch (error) {
      print(error.toString());
    }
  }
}
