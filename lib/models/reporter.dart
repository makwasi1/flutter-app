import 'package:citizen_feedback/models/district.dart';
import 'package:citizen_feedback/models/user.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';

@jsonSerializable
class Reporter{
  String id;
  User user;
  String telephone;
  String name;
  String registrationDate;
  District district;

  Reporter({
    this.id,
    this.user,
    this.telephone,
    this.name,
    this.registrationDate,
    this.district,
  });

}
