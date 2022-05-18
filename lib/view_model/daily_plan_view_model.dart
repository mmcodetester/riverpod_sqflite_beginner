import 'dart:ffi';

class DailyPlanSubModuleViewModel {
  int? id;
  String? name;
  String? date;
  int? dailyPlanId;
  String? dailyPlanName;
  Bool? isComplete;
  String? whynot;

  DailyPlanSubModuleViewModel(
      {this.id,
      this.name,
      this.date,
      this.dailyPlanId,
      this.isComplete,
      this.whynot});
}
