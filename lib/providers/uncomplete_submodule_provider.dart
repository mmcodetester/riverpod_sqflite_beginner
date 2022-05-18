// ignore_for_file: unused_local_variable

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:provider_app/models/daily_paln_submodule.dart';
import 'package:provider_app/utils/plan_db.dart';

final uncompleteSubModuleProvider = StateNotifierProvider.autoDispose<
    GetDailyPlanSubModule,
    List<DailyPlanSubModule>>((ref) => GetDailyPlanSubModule());

class GetDailyPlanSubModule extends StateNotifier<List<DailyPlanSubModule>> {
  GetDailyPlanSubModule() : super([]) {
    getallDailyPlanSubModule();
  }
  getallDailyPlanSubModule() async {
    DateTime today = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(today);
    final note = [];
    final notes =
        await PlanDatabase.instance.getAllDailyUncompletePlanSubModule(date);
    notes.forEach((element) {
      if (!element.isComplete!) {
        note.add(element);
      }
    });
    state = [];
    state = [...note];
  }

  update(DailyPlanSubModule module) async {
    DateTime today = DateTime.now();
    String date = DateFormat('yyyy-MM-dd').format(today);
    final data = await PlanDatabase.instance.updateSubModule(module);
    final note = [];
    final notes =
        await PlanDatabase.instance.getAllDailyUncompletePlanSubModule(date);
    notes.forEach((element) {
      if (!element.isComplete!) {
        note.add(element);
      }
    });
    //print(note);
    state = [];
    state = [...note];
    //state.where((element) => element.isComplete == 0);
  }
}
