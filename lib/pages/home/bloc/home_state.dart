part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({
    required this.model,
  });

  final Model model;

  @override
  List<Object?> get props => [
        model,
      ];
}

class LoadingState extends HomeState {
  const LoadingState({required super.model});
}

class SuccessState extends HomeState {
  const SuccessState({required super.model});
}

class FailState extends HomeState {
  const FailState({required super.model});
}

class Model extends Equatable {
  const Model({
    required this.categories,
    required this.products,
    required this.filteredProducts,
    required this.selectedCategory,
  });

  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final List<ProductModel> filteredProducts;
  final CategoryModel? selectedCategory;

  Model copyWith({
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    List<ProductModel>? filteredProducts,
    CategoryModel? selectedCategory,
  }) =>
      Model(
        categories: categories ?? this.categories,
        products: products ?? this.products,
        filteredProducts: filteredProducts ?? this.filteredProducts,
        selectedCategory: selectedCategory ?? this.selectedCategory,
      );

  @override
  List<Object?> get props => [
        categories,
        products,
        filteredProducts,
        selectedCategory,
      ];
}
