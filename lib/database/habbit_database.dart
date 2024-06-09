import 'package:flutter/material.dart';
import 'package:habbittrack/models/app_settings.dart';
import 'package:habbittrack/models/habbit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class Habbitdatabase extends ChangeNotifier {
  static late Isar isar;

  //initialize

  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([HabbitSchema, AppSettingsSchema], directory: dir.path);
  }

  //save initial launch date

  static Future<void> saveFirstLaunchDate() async {
    final existingsettings = await isar.appSettings.where().findFirst();

    if (existingsettings == null) {
      final settings = AppSettings()..FirstLaunchDate = DateTime.now();
      await isar.writeTxn(() => isar.appSettings.put(settings));
    }
  }

  Future<DateTime?> getFirstLaunchDate() async {
    final settings = await isar.appSettings.where().findFirst();
    return settings?.FirstLaunchDate;
  }

  //initialize habbits

  List<Habbit> habbits = [];

  //add a habbit

  Future<void> addHabbit(String habbitname) async {
    final newhabit = Habbit()..name = habbitname;
    await isar.writeTxn(() => isar.habbits.put(newhabit));

    readhabbits();
  }

  Future<void> readhabbits() async {
    List<Habbit> fetchedhabbits = await isar.habbits.where().findAll();
    habbits.clear();
    habbits.addAll(fetchedhabbits);

    notifyListeners();
  }

  Future<void> updateHabbitCompletion(int id, bool iscompleted) async {
    final habbit = await isar.habbits.get(id);
    if (habbit != null) {
      await isar.writeTxn(() async {
        if (iscompleted && !habbit.completedDays.contains(DateTime.now())) {
          final today = DateTime.now();
          habbit.completedDays
              .add(DateTime(today.year, today.month, today.day));
        } else {
          habbit.completedDays.removeWhere((date) =>
              date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day);
        }
        await isar.habbits.put(habbit);
      });
    }
    readhabbits();
  }

  Future<void> edithabbitname(int id, String newname) async {
    final habbit = await isar.habbits.get(id);
    if (habbit != null) {
      await isar.writeTxn(() async {
        habbit.name = newname;
        await isar.habbits.put(habbit);
      });
    }
    readhabbits();
  }

  Future<void> deleteHabbit(int id) async {
    await isar.writeTxn(() async {
      await isar.habbits.delete(id);
    });
    readhabbits();
  }
}
