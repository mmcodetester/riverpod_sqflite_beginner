import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/user/user_model.dart';
import '../../utils/plan_db.dart';

final userProvider =
    StateNotifierProvider.autoDispose<UserDataProvider, List<User>>(
        (ref) => UserDataProvider());

class UserDataProvider extends StateNotifier<List<User>> {
  UserDataProvider() : super([]) {
    getUser();
  }
  getUser() async {
    final users = await PlanDatabase.instance.getUser();
    state = [];
    state = [...users];
  }

  createUser(User user) async {
    // ignore: unused_local_variable
    final result = await PlanDatabase.instance.createUser(user);
    final users = await PlanDatabase.instance.getUser();
    state = [];
    state = [...users];
  }

  updateUser(User user) async {
    // ignore: unused_local_variable
    final result = await PlanDatabase.instance.updateUser(user);
    final users = await PlanDatabase.instance.getUser();
    state = [];
    state = [...users];
  }
}
