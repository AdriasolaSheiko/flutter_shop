import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_shop/pages/admin/children/products/bloc/products_bloc.dart';
import 'package:flutter_shop/pages/admin/children/products/sections/add_product_dialog.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc()
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
    final bloc = BlocProvider.of<ProductsBloc>(context);
    return Scaffold(
      body: BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
        return state is LoadingState || state is FailState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: state.model.products.length,
                    itemBuilder: (_, index) {
                      final category = state.model.categories.firstWhere((e) =>
                          e.uid == state.model.products[index].categoryUid);
                      return Card(
                        child: ListTile(
                          trailing: InkWell(
                            onTap: () async {
                              final product = await AddProductDialog(
                                productsBloc: bloc,
                                productModel: state.model.products[index],
                              ).show(context);
                              if (product != null) {
                                bloc.add(
                                  ModifyProductEvent(
                                    product: product,
                                  ),
                                );
                              }
                            },
                            child: const Icon(Icons.edit),
                          ),
                          title: Row(
                            children: [
                              Text(
                                state.model.products[index].name,
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
                                'Precio: \$${state.model.products[index].price.toStringAsFixed(2)}',
                              ),
                              const Spacer(),
                              Text(
                                'Existencia: ${state.model.products[index].stock}',
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
      }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final product = await AddProductDialog(
            productsBloc: bloc,
          ).show(context);
          if (product != null) {
            bloc.add(
              CreateProductEvent(
                product: product,
              ),
            );
          }
        },
      ),
    );
  }
}
