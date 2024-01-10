


import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:gritstone/HiveDB/hive_model.dart';

ValueNotifier<List<AddTextModel>> addTextNotifier = ValueNotifier([]) ;

Future<void> addToTextToList(AddTextModel value) async{
  final textDb = await Hive.box<AddTextModel>('add_text_db');
  await textDb.add(value);
  addTextNotifier.value.add(value);
  addTextNotifier.notifyListeners();
}

Future<void> getAllText() async {
  final textDb = await Hive.box<AddTextModel>('add_text_db');
  addTextNotifier.value.clear();
  addTextNotifier.value.addAll(textDb.values);
  addTextNotifier.notifyListeners();


}

Future<void> deleteTextFromList(int index) async {
  final textDb = await Hive.box<AddTextModel>('add_text_db');
  await textDb.delete(index);
  getAllText();
}