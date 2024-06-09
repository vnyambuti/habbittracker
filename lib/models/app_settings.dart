import 'package:flutter/material.dart';

import 'package:isar/isar.dart';

part 'app_settings.g.dart';

@collection
class AppSettings {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  DateTime? FirstLaunchDate;
}
