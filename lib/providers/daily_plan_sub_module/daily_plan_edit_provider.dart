import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider_app/models/daily_paln_submodule.dart';
import 'package:provider_app/utils/plan_db.dart';

final dailyPlanEditProvider =
    FutureProvider.autoDispose.family<DailyPlanSubModule, int?>((ref, id) {
  final module = PlanDatabase.instance.getDailyPlanSubModuleById(id!);
  return module;
});
