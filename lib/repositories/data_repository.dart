import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_shop/models/user_model.dart';

class DataRepository {
  static final DataRepository _dataRepository = DataRepository._internal();

  factory DataRepository() {
    return _dataRepository;
  }

  Future<List<UserModel>> getUsers() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref('users');
    final response = await ref.once();
    final data = response.snapshot.value as Map?;
    if (data == null) {
      return [];
    }
    return data.entries
        .map(
          (e) => UserModel.fromJson(
            e.value,
          ),
        )
        .toList();
  }

  DataRepository._internal();
}
