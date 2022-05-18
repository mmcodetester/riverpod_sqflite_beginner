String dailyPlanTable = 'daily_plan';

class DailyPlanFields {
  static String id = '_id';
  static String name = 'name';
  static String description = 'description';
  static String fromdate = 'fromdate';
  static String todate = 'todate';
  static String islearning = 'islearning';
}

class DailyPlan {
  int? id;
  String? name;
  String? description;
  String? fromdate;
  String? todate;
  bool? islearning;

  DailyPlan(
      {this.id,
      this.name,
      this.description,
      this.fromdate,
      this.todate,
      this.islearning});

  factory DailyPlan.fromJson(Map<String, dynamic> map) {
    return DailyPlan(
        id: map[DailyPlanFields.id] as int,
        name: map[DailyPlanFields.name] as String,
        description: map[DailyPlanFields.description] as String?,
        fromdate: map[DailyPlanFields.fromdate] as String?,
        todate: map[DailyPlanFields.todate] as String?,
        islearning: map[DailyPlanFields.islearning] == 1 ? true : false);
  }

  Map<String, dynamic> toJson() => {
        DailyPlanFields.id: id,
        DailyPlanFields.name: name,
        DailyPlanFields.description: description,
        DailyPlanFields.fromdate: fromdate,
        DailyPlanFields.todate: todate,
        DailyPlanFields.islearning: islearning
      };
}
