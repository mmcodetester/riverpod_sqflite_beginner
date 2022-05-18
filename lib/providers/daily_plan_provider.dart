import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_app/utils/plan_db.dart';

import '../models/daily_plan_model.dart';

final dailyPlanProvider =
    StateNotifierProvider.autoDispose<GetDailyPlan, List<DailyPlan>>(
        (ref) => GetDailyPlan());

class GetDailyPlan extends StateNotifier<List<DailyPlan>> {
  GetDailyPlan() : super([]) {
    getallDailyPlan();
  }
  getallDailyPlan() async {
    final notes = await PlanDatabase.instance.getAllDailyPlans();
    state = [];
    state = [...notes];
  }

  createDailyPlan(DailyPlan dailyPlan) async {
    DailyPlan _dailyPlan =
        await PlanDatabase.instance.createDailyPlan(dailyPlan);
    state = [...state, _dailyPlan];
  }

  delete(int id) async {
    await PlanDatabase.instance.deleteDailyPlan(id);
    final notes = await PlanDatabase.instance.getAllDailyPlans();
    state = [];
    state = [...notes];
  }
}
