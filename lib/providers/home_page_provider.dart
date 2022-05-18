import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_app/models/daily_paln_submodule.dart';
import 'package:provider_app/utils/plan_db.dart';

final completedailyPlanSubModuleProvider = StateNotifierProvider.autoDispose<
    GetDailyPlanSubModule,
    List<DailyPlanSubModule>>((ref) => GetDailyPlanSubModule());

class GetDailyPlanSubModule extends StateNotifier<List<DailyPlanSubModule>> {
  GetDailyPlanSubModule() : super([]) {
    getallcompleteDailyPlanSubModule();
  }
  getallcompleteDailyPlanSubModule() async {
    final note = [];
    final notes = await PlanDatabase.instance.getAllDailyPlanSubModule();
    notes.forEach((element) {
      if (element.isComplete == true) {
        note.add(element);
      }
    });
    state = [];

    state = [...note];
  }
}
