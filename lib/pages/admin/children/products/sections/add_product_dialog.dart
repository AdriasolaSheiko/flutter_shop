import 'package:flutter/material.dart';
import 'package:flutter_shop/models/category_model.dart';
import 'package:flutter_shop/models/product_model.dart';
import 'package:flutter_shop/pages/admin/children/products/bloc/products_bloc.dart';

class AddProductDialog extends StatelessWidget {
  const AddProductDialog({
    super.key,
    required this.productsBloc,
    this.productModel,
  });

  final ProductsBloc productsBloc;
  final ProductModel? productModel;

  @override
  Widget build(BuildContext context) {
    final nameController =
        TextEditingController(text: productModel?.name ?? '');
    final brandController =
        TextEditingController(text: productModel?.brand ?? '');
    final descriptionController =
        TextEditingController(text: productModel?.description ?? '');
    final priceController =
        TextEditingController(text: productModel?.price.toString() ?? '');
    final stockController =
        TextEditingController(text: productModel?.stock.toString() ?? '');
    final selectedCategory = productModel == null
        ? null
        : productsBloc.state.model.categories
            .firstWhere((e) => e.uid == productModel!.categoryUid);
    final ValueNotifier<CategoryModel> categoryNotifier = ValueNotifier(
      selectedCategory ?? productsBloc.state.model.categories.first,
    );
    return AlertDialog(
      title:
          Text(productModel != null ? 'Editar producto' : 'Agregar producto'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Nombre'),
            controller: nameController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Marca'),
            controller: brandController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Descripcion'),
            controller: descriptionController,
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Precio'),
            controller: priceController,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
            ),
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Existencias'),
            controller: stockController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              const Text(
                'Categoría: ',
                style: TextStyle(fontSize: 17),
              ),
              const Spacer(),
              ValueListenableBuilder<CategoryModel>(
                  valueListenable: categoryNotifier,
                  builder: (context, selected, _) {
                    return DropdownButton<CategoryModel>(
                      value: selected,
                      items: productsBloc.state.model.categories
                          .map(
                            (e) => DropdownMenuItem<CategoryModel>(
                              value: e,
                              child: Text(e.name),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        categoryNotifier.value = value!;
                      },
                    );
                  })
            ],
          ),
        ],
      ),
      actions: [
        if (productModel != null)
          TextButton(
            onPressed: () {
              productsBloc.add(DeleteProductEvent(uid: productModel!.uid));
              Navigator.of(context).pop(null);
            },
            child: const Text(
              'Eliminar',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        TextButton(
          onPressed: () {
            if (double.tryParse(priceController.text) != null &&
                int.tryParse(stockController.text) != null) {
              Navigator.of(context).pop(
                ProductModel(
                  name: nameController.text,
                  uid: productModel?.uid ?? '',
                  categoryUid: categoryNotifier.value.uid,
                  brand: brandController.text,
                  price: double.parse(priceController.text),
                  stock: int.parse(stockController.text),
                  description: descriptionController.text,
                ),
              );
            }
          },
          child: Text(
            productModel != null ? 'Editar' : 'Agregar',
          ),
        ),
      ],
    );
  }

  Future<ProductModel?> show(BuildContext context) async {
    return showDialog<ProductModel>(
      context: context,
      builder: (_) => this,
    );
  }
}
