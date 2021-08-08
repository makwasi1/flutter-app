import 'package:dart_json_mapper/dart_json_mapper.dart';

///Region model
@jsonSerializable
class Region {
  String id;
  String name;
  String code;

  Region({this.id, this.name, this.code});
}
