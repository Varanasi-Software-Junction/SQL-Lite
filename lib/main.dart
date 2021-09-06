import 'package:flutter/material.dart';
import 'dart:async';
import 'vsjsqlite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'databasehandler.dart';

void main() async {
  await DatabaseHandler.initialize();
  runApp(VsjSqlite());
}
