import 'package:citizen_feedback/models/user.dart';
import 'package:flutter/foundation.dart';

class AuthCredentials {
  final String username;
  User user;

  AuthCredentials({
    @required this.username,
    this.user,
  });
}
