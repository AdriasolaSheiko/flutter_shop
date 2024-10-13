import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/models/category_model.dart';
import 'package:flutter_shop/repositories/categories_repository.dart';
part 'categories_state.dart';
part 'categories_event.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc()
      : super(
          const LoadingState(
            model: Model(
              categories: [],
            ),
          ),
        ) {
    on<LoadEvent>(_onLoadEvent);
    on<CreateCategoryEvent>(_onCreateCategoryEvent);
  }

  void _onLoadEvent(LoadEvent event, emit) async {
    emit(
      LoadingState(
        model: state.model,
      ),
    );

    try {
      final categories = await CategoriesRepository().getCategories();

      emit(
        SuccessState(
          model: state.model.copyWith(
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

  void _onCreateCategoryEvent(CreateCategoryEvent event, emit) async {
    emit(
      LoadingState(
        model: state.model,
      ),
    );
    try {
      await CategoriesRepository().createCategory(
        name: event.name,
      );
      final categories = await CategoriesRepository().getCategories();

      emit(
        SuccessState(
          model: state.model.copyWith(
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
}
