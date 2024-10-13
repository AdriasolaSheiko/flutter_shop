part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {
  SearchEvent({
    required this.searchBy,
  });
  final String searchBy;
  @override
  List<Object?> get props => [
        searchBy,
      ];
}

class FilterEvent extends HomeEvent {
  FilterEvent({
    required this.filterBy,
  });
  final CategoryModel filterBy;
  @override
  List<Object?> get props => [
        filterBy,
      ];
}
