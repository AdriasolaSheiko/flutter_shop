import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_shop/models/category_model.dart';

class CategoriesRepository {
  static final CategoriesRepository _categoriesRepository =
      CategoriesRepository._internal();

  factory CategoriesRepository() {
    return _categoriesRepository;
  }

  Future<List<CategoryModel>> getCategories() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('categories');
    final response = await ref.once();
    final data = response.snapshot.value as Map?;
    if (data == null) {
      return [];
    }
    return data.entries
        .map(
          (e) => CategoryModel.fromJson(
            e.value,
          ),
        )
        .toList();
  }

  Future<void> createCategory({
    required String name,
  }) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('categories');
    final newRef = ref.push();
    final categoryModel = CategoryModel(
      name: name,
      uid: (await newRef.get()).key ?? '',
    );
    await newRef.set(
      categoryModel.toJson(),
    );
  }

  CategoriesRepository._internal();
}
