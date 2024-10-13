part of 'categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEvent extends CategoriesEvent {}

class CreateCategoryEvent extends CategoriesEvent {
  CreateCategoryEvent({
    required this.name,
  });
  final String name;

  @override
  List<Object?> get props => [
        name,
      ];
}
