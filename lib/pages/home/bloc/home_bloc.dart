import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/models/category_model.dart';
import 'package:flutter_shop/models/product_model.dart';
import 'package:flutter_shop/repositories/categories_repository.dart';
import 'package:flutter_shop/repositories/products_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc()
      : super(
          const LoadingState(
            model: Model(
              categories: [],
              products: [],
              filteredProducts: [],
              selectedCategory: null,
            ),
          ),
        ) {
    on<LoadEvent>(_onLoadEvent);
    on<SearchEvent>(_onSearchEvent);
    on<FilterEvent>(_onFilterEvent);
  }

  void _onLoadEvent(LoadEvent event, emit) async {
    emit(
      LoadingState(
        model: state.model,
      ),
    );

    try {
      final products = await ProductsRepository().getProducts();
      final categories = [
        CategoryModel(name: 'Todo', uid: 'all'),
        ...await CategoriesRepository().getCategories()
      ];

      emit(
        SuccessState(
          model: state.model.copyWith(
            products: products,
            categories: categories,
            filteredProducts: products,
            selectedCategory: categories.first,
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

  void _onSearchEvent(SearchEvent event, emit) async {
    emit(
      LoadingState(
        model: state.model,
      ),
    );

    try {
      final products = state.model.products
          .where(
            (e) => e.name.toLowerCase().contains(
                  event.searchBy,
                ),
          )
          .toList();

      emit(
        SuccessState(
          model: state.model.copyWith(
            filteredProducts: products,
            selectedCategory: state.model.categories.first,
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

  void _onFilterEvent(FilterEvent event, emit) async {
    emit(
      LoadingState(
        model: state.model,
      ),
    );

    try {
      final List<ProductModel> products = List.empty(growable: true);
      if (event.filterBy.uid == 'all') {
        products.addAll(state.model.products);
      } else {
        products.addAll(state.model.products
            .where((e) => e.categoryUid == event.filterBy.uid));
      }

      emit(
        SuccessState(
          model: state.model.copyWith(
            filteredProducts: products,
            selectedCategory: event.filterBy,
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
