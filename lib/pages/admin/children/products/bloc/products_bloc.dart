import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/models/category_model.dart';
import 'package:flutter_shop/models/product_model.dart';
import 'package:flutter_shop/repositories/categories_repository.dart';
import 'package:flutter_shop/repositories/products_repository.dart';
part 'products_state.dart';
part 'products_event.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc()
      : super(
          const LoadingState(
            model: Model(products: [], categories: []),
          ),
        ) {
    on<LoadEvent>(_onLoadEvent);
    on<CreateProductEvent>(_onCreateProductEvent);
    on<ModifyProductEvent>(_onModifyProductEvent);
    on<DeleteProductEvent>(_onDeleteProductEvent);
  }

  void _onLoadEvent(LoadEvent event, emit) async {
    emit(
      LoadingState(
        model: state.model,
      ),
    );

    try {
      final products = await ProductsRepository().getProducts();
      final categories = await CategoriesRepository().getCategories();

      emit(
        SuccessState(
          model: state.model.copyWith(
            products: products,
            categories: categories,
          ),
        ),
      );
    } catch (_) {
      emit(
        FailState(
          model: state.model,
        ),
      );
    }
  }

  void _onDeleteProductEvent(DeleteProductEvent event, emit) async {
    emit(
      LoadingState(
        model: state.model,
      ),
    );
    try {
      await ProductsRepository().deleteProduct(
        uid: event.uid,
      );
      final products = await ProductsRepository().getProducts();

      emit(
        SuccessState(
          model: state.model.copyWith(
            products: products,
          ),
        ),
      );
    } catch (_) {
      emit(
        FailState(
          model: state.model,
        ),
      );
    }
  }

  void _onCreateProductEvent(CreateProductEvent event, emit) async {
    emit(
      LoadingState(
        model: state.model,
      ),
    );
    try {
      await ProductsRepository().createProduct(
        product: event.product,
      );
      final products = await ProductsRepository().getProducts();

      emit(
        SuccessState(
          model: state.model.copyWith(
            products: products,
          ),
        ),
      );
    } catch (_) {
      emit(
        FailState(
          model: state.model,
        ),
      );
    }
  }

  void _onModifyProductEvent(ModifyProductEvent event, emit) async {
    emit(
      LoadingState(
        model: state.model,
      ),
    );
    try {
      await ProductsRepository().modifyProduct(
        product: event.product,
      );
      final products = await ProductsRepository().getProducts();

      emit(
        SuccessState(
          model: state.model.copyWith(
            products: products,
          ),
        ),
      );
    } catch (_) {
      emit(
        FailState(
          model: state.model,
        ),
      );
    }
  }
}
