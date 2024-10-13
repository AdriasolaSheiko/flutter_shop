part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  final Model model;

  const ProductsState({
    required this.model,
  });

  @override
  List<Object?> get props => [
        model,
      ];
}

class LoadingState extends ProductsState {
  const LoadingState({required super.model});
}

class SuccessState extends ProductsState {
  const SuccessState({required super.model});
}

class FailState extends ProductsState {
  const FailState({required super.model});
}

class Model extends Equatable {
  const Model({
    required this.products,
    required this.categories,
  });

  final List<ProductModel> products;
  final List<CategoryModel> categories;

  Model copyWith({
    List<ProductModel>? products,
    List<CategoryModel>? categories,
  }) =>
      Model(
        products: products ?? this.products,
        categories: categories ?? this.categories,
      );

  @override
  List<Object?> get props => [
        products,
        categories,
      ];
}
