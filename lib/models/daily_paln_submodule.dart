String dailyPlanSubModuleTable = 'daily_plan_submodule';

class DailyPlanSubModuleFields {
  static String id = '_id';
  static String name = 'name';
  static String date = 'date';
  static String iscomplete = 'islearning';
  static String dailyplanid = 'dailyplanid';
  static String whynot = 'whynot';
}

class DailyPlanSubModule {
  int? id;
  String? name;
  String? date;
  bool? isComplete;
  int? dailyplanid;
  String? whynot;

  DailyPlanSubModule(
      {this.id,
      this.name,
      this.date,
      this.isComplete,
      this.dailyplanid,
      this.whynot});

  factory DailyPlanSubModule.fromJson(Map<String, dynamic> map) {
    return DailyPlanSubModule(
        id: map[DailyPlanSubModuleFields.id] as int,
        name: map[DailyPlanSubModuleFields.name] as String?,
        date: map[DailyPlanSubModuleFields.date] as String?,
        isComplete:
            map[DailyPlanSubModuleFields.iscomplete] == 1 ? true : false,
        dailyplanid: map[DailyPlanSubModuleFields.dailyplanid] as int?,
        whynot: map[DailyPlanSubModuleFields.whynot] as String?);
  }

  Map<String, dynamic> toJson() => {
        DailyPlanSubModuleFields.id: id,
        DailyPlanSubModuleFields.name: name,
        DailyPlanSubModuleFields.date: date,
        DailyPlanSubModuleFields.iscomplete: isComplete,
        DailyPlanSubModuleFields.dailyplanid: dailyplanid,
        DailyPlanSubModuleFields.whynot: whynot
      };
}
