import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_app/models/daily_paln_submodule.dart';
import 'package:provider_app/utils/plan_db.dart';

final dailyPlanSubModuleProvider = StateNotifierProvider.autoDispose<
    GetDailyPlanSubModule,
    List<DailyPlanSubModule>>((ref) => GetDailyPlanSubModule());

class GetDailyPlanSubModule extends StateNotifier<List<DailyPlanSubModule>> {
  GetDailyPlanSubModule() : super([]) {
    getallDailyPlanSubModule();
  }
  getallDailyPlanSubModule() async {
    final notes = await PlanDatabase.instance.getAllDailyPlanSubModule();
    state = [];
    state = [...notes];
  }

  createDailyPlanSubModule(DailyPlanSubModule module) async {
    // ignore: unused_local_variable
    final data = await PlanDatabase.instance.createDailyPlanSubModule(module);
    final notes = await PlanDatabase.instance.getAllDailyPlanSubModule();
    state = [];
    state = [...notes];
  }

  update(DailyPlanSubModule module) async {
    // ignore: unused_local_variable
    final data = await PlanDatabase.instance.updateSubModule(module);
    final notes = await PlanDatabase.instance.getAllDailyPlanSubModule();
    state = [];
    state = [...notes];
  }

  search(String? module) async {
    state.where((element) => element.name!.contains(module!)).toList();
  }

  delete(int id) async {
    // ignore: unused_local_variable
    await PlanDatabase.instance.deleteDailyPlanSubModule(id);
    final notes = await PlanDatabase.instance.getAllDailyPlanSubModule();
    state = [];
    state = [...notes];
  }
}
