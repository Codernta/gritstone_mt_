
import 'package:hive/hive.dart';

part 'hive_model.g.dart';


@HiveType(typeId: 0,adapterName: "AddTextAdapter")
class AddTextModel {


  @HiveField(0)
  String? textToSave;





  AddTextModel({
    required this.textToSave,
  });
}


