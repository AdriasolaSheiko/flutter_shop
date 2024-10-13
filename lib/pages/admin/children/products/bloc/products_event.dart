part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadEvent extends ProductsEvent {}

class DeleteProductEvent extends ProductsEvent {
  DeleteProductEvent({
    required this.uid,
  });

  final String uid;

  @override
  List<Object?> get props => [
        uid,
      ];
}

class CreateProductEvent extends ProductsEvent {
  CreateProductEvent({
    required this.product,
  });

  final ProductModel product;

  @override
  List<Object?> get props => [
        product,
      ];
}

class ModifyProductEvent extends ProductsEvent {
  ModifyProductEvent({
    required this.product,
  });

  final ProductModel product;

  @override
  List<Object?> get props => [
        product,
      ];
}
