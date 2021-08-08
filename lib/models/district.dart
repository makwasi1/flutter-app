import 'package:citizen_feedback/models/region.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

///District model
@jsonSerializable
class District {
  String id;
  String name;
  String code;
  Region region;

  District({
    this.id,
    this.name,
    this.code,
    this.region
  });
}
