import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/daily_paln_submodule.dart';
import '../models/daily_plan_model.dart';
import '../models/user/user_model.dart';

class PlanDatabase {
  static final PlanDatabase instance = PlanDatabase._init();
  static Database? _database;
  PlanDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('[goal.db]');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath.toString(), filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    String textType = "TEXT";
    String intType = "INTEGER";
    //String datetimeType = "Datetime";
    //String dateType = "Date";
    String booleanType = "boolean";
    //String integerType = "INTEGER NOT NULL";
    await db.execute('''
    create table $dailyPlanTable ( 
      ${DailyPlanFields.id} $idType,
      ${DailyPlanFields.name} $textType,
      ${DailyPlanFields.description} $textType,
      ${DailyPlanFields.fromdate} $textType,
      ${DailyPlanFields.todate} $textType,
      ${DailyPlanFields.islearning} $booleanType
    )
    ''');

    await db.execute('''
    create table $dailyPlanSubModuleTable ( 
      ${DailyPlanSubModuleFields.id} $idType,
      ${DailyPlanSubModuleFields.name} $textType,
      ${DailyPlanSubModuleFields.date} $textType,
      ${DailyPlanSubModuleFields.iscomplete} $booleanType,
      ${DailyPlanSubModuleFields.dailyplanid} $intType,
      ${DailyPlanSubModuleFields.whynot} $textType
    )
    ''');

    await db.execute('''
    create table $userTable ( 
      ${UserFields.id} $idType,
      ${UserFields.name} $textType,
      ${UserFields.gender} $textType,
      ${UserFields.image} $textType
    )
    ''');
  }

  Future<List<DailyPlan>> getAllDailyPlans() async {
    final db = await instance.database;
    final orderBy = '${DailyPlanFields.id} DESC';
    final List<Map<String, dynamic>> result =
        await db.query(dailyPlanTable, orderBy: orderBy);
    return result.map((data) => DailyPlan.fromJson(data)).toList();
  }

  Future<List<DailyPlanSubModule>> getAllDailyPlanSubModule() async {
    final db = await instance.database;
    final orderBy = '${DailyPlanSubModuleFields.id} DESC';
    final List<Map<String, dynamic>> result =
        await db.query(dailyPlanSubModuleTable, orderBy: orderBy);
    return result.map((data) => DailyPlanSubModule.fromJson(data)).toList();
  }

  Future<DailyPlanSubModule> getDailyPlanSubModuleById(int id) async {
    final db = await instance.database;
    final result = await db.query(dailyPlanSubModuleTable,
        where: '${DailyPlanSubModuleFields.id} = ?', whereArgs: [id]);
    final data = result.first;

    return DailyPlanSubModule.fromJson(data);
  }

  Future<List<DailyPlanSubModule>> getAllDailyUncompletePlanSubModule(
      String date) async {
    final db = await instance.database;
    //final orderBy = '${DailyPlanSubModuleFields.id} DESC';
    final List<Map<String, dynamic>> result = await db.query(
        dailyPlanSubModuleTable,
        where: '${DailyPlanSubModuleFields.date} =?',
        whereArgs: [date]);
    //print(result.length);
    return result.map((data) => DailyPlanSubModule.fromJson(data)).toList();
  }

  Future<DailyPlanSubModule> updateSubModule(DailyPlanSubModule module) async {
    DailyPlanSubModule result = DailyPlanSubModule();
    final db = await instance.database;
    final id = await db.update(dailyPlanSubModuleTable, module.toJson(),
        where: '${DailyPlanSubModuleFields.id} = ?', whereArgs: [module.id]);
    result.id = id;
    return result;
  }

  Future<DailyPlan> createDailyPlan(DailyPlan plan) async {
    //print(note.title);
    DailyPlan dailyPlan = DailyPlan();
    final db = await instance.database;
    final id = await db.insert(dailyPlanTable, plan.toJson());
    dailyPlan.id = id;
    return dailyPlan;
  }

  Future<DailyPlanSubModule> createDailyPlanSubModule(
      DailyPlanSubModule plan) async {
    //print(note.title);
    DailyPlanSubModule dailyPlan = DailyPlanSubModule();
    final db = await instance.database;
    final id = await db.insert(dailyPlanSubModuleTable, plan.toJson());
    dailyPlan.id = id;
    return dailyPlan;
  }

  Future<User> createUser(User user) async {
    //User user = User();
    final db = await instance.database;
    final id = await db.insert(userTable, user.toJson());
    user.id = id;
    return user;
  }

  Future<User> updateUser(User user) async {
    User result = User();
    final db = await instance.database;
    final id = await db.update(userTable, user.toJson(),
        where: '${UserFields.id} = ?', whereArgs: [user.id]);
    result.id = id;
    return result;
  }

  Future<List<User>> getUser() async {
    // User user = User();
    final db = await instance.database;
    final List<Map<String, dynamic>> data = await db.query(userTable);
    return data.map((data) => User.fromJson(data)).toList();
  }

  Future<int> deleteDailyPlan(int id) async {
    final db = await instance.database;
    return await db.delete(
      dailyPlanTable,
      where: '${DailyPlanFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteDailyPlanSubModule(int id) async {
    final db = await instance.database;
    return await db.delete(
      dailyPlanSubModuleTable,
      where: '${DailyPlanSubModuleFields.dailyplanid} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
