part of 'categories_bloc.dart';

abstract class CategoriesState extends Equatable {
  final Model model;

  const CategoriesState({
    required this.model,
  });

  @override
  List<Object?> get props => [
        model,
      ];
}

class LoadingState extends CategoriesState {
  const LoadingState({required super.model});
}

class SuccessState extends CategoriesState {
  const SuccessState({required super.model});
}

class FailState extends CategoriesState {
  const FailState({required super.model});
}

class Model extends Equatable {
  const Model({
    required this.categories,
  });

  final List<CategoryModel> categories;

  Model copyWith({List<CategoryModel>? categories}) => Model(
        categories: categories ?? this.categories,
      );

  @override
  List<Object?> get props => [
        categories,
      ];
}
