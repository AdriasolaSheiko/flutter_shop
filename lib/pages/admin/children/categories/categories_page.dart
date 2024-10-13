import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/pages/admin/children/categories/bloc/categories_bloc.dart';
import 'package:flutter_shop/pages/admin/children/categories/sections/add_category_dialog.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesBloc()
        ..add(
          LoadEvent(),
        ),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<CategoriesBloc>(context);
    return Scaffold(
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
        return state is LoadingState || state is FailState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: state.model.categories.length,
                    itemBuilder: (_, index) {
                      return Card(
                        child: ListTile(
                          title: Text(
                            state.model.categories[index].name,
                          ),
                        ),
                      );
                    }),
              );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final categoryName = await const AddCategoryDialog().show(context);
          if (categoryName != null) {
            bloc.add(
              CreateCategoryEvent(
                name: categoryName,
              ),
            );
          }
        },
      ),
    );
  }
}
