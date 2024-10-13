import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/models/category_model.dart';
import 'package:flutter_shop/pages/home/bloc/home_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()
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
    final bloc = BlocProvider.of<HomeBloc>(context);
    final searchController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter shop'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
        return state is LoadingState || state is FailState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.search),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            onChanged: (value) {
                              bloc.add(
                                SearchEvent(
                                  searchBy: value,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 16.0,
                        ),
                        DropdownButton<CategoryModel>(
                          value: state.model.selectedCategory,
                          items: state.model.categories
                              .map(
                                (e) => DropdownMenuItem<CategoryModel>(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            bloc.add(
                              FilterEvent(
                                filterBy: value!,
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: state.model.filteredProducts.length,
                          itemBuilder: (_, index) {
                            final category = state.model.categories.firstWhere(
                                (e) =>
                                    e.uid ==
                                    state.model.filteredProducts[index]
                                        .categoryUid);
                            return Card(
                              child: ListTile(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text(
                                        state
                                            .model.filteredProducts[index].name,
                                      ),
                                      content: Text(
                                        state.model.filteredProducts[index]
                                            .description,
                                      ),
                                    ),
                                  );
                                },
                                title: Row(
                                  children: [
                                    Text(
                                      state.model.filteredProducts[index].name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                    Text(category.name),
                                  ],
                                ),
                                subtitle: Row(
                                  children: [
                                    Text(
                                      'Precio: \$${state.model.filteredProducts[index].price.toStringAsFixed(2)}',
                                    ),
                                    const Spacer(),
                                    Text(
                                      'Existencia: ${state.model.filteredProducts[index].stock}',
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
      }),
    );
  }
}
