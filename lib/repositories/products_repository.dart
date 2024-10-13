import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_shop/models/product_model.dart';

class ProductsRepository {
  static final ProductsRepository _productsRepository =
      ProductsRepository._internal();

  factory ProductsRepository() {
    return _productsRepository;
  }

  Future<List<ProductModel>> getProducts() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('products');
    final response = await ref.once();
    final data = response.snapshot.value as Map?;
    if (data == null) {
      return [];
    }
    return data.entries
        .map(
          (e) => ProductModel.fromJson(
            e.value,
          ),
        )
        .toList();
  }

  Future<void> deleteProduct({required String uid}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('products/$uid');
    await ref.remove();
  }

  Future<void> createProduct({
    required ProductModel product,
  }) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('products');
    final newRef = ref.push();
    final productModel = ProductModel(
      name: product.name,
      uid: (await newRef.get()).key ?? '',
      categoryUid: product.categoryUid,
      brand: product.brand,
      description: product.description,
      price: product.price,
      stock: product.stock,
    );
    await newRef.set(
      productModel.toJson(),
    );
  }

  Future<void> modifyProduct({
    required ProductModel product,
  }) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref('products/${product.uid}');

    await ref.set(
      product.toJson(),
    );
  }

  ProductsRepository._internal();
}
