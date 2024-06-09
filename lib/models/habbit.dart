import 'package:flutter/material.dart';

import 'package:isar/isar.dart';

part 'habbit.g.dart';

@collection
class Habbit {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  late String name;

  List<DateTime> completedDays = [];
}
