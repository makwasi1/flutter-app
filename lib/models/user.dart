import 'package:citizen_feedback/models/district.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:equatable/equatable.dart';

///User model
@jsonSerializable
class User extends Equatable {
  String id;
  String username;
  String password;
  String telephoneNumber;
  String accessToken;
  District district;

  User(
      {this.id,
        this.username,
        this.password,
        this.telephoneNumber,
        this.accessToken,
        this.district
      });

  @override
  List<Object> get props => [username, password, accessToken];
}
