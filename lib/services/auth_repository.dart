import 'package:citizen_feedback/models/http_msg_model.dart';
import 'package:citizen_feedback/models/region.dart';
import 'package:citizen_feedback/shared/exceptions/app_exception.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';


import '../models/user.dart';
import '../models/district.dart';
import 'auth_credentials.dart';
import 'http_utils.dart';

abstract class AuthRepositoryService {
  Future<User> login(String username, String password);

  Future<String> getCurrentUserToken();

  Future<User> getCurrentLoggedInUser();

  Future<void> logout();

  Future<void> storeLoggedInUser(User user);

  Future<HttpMsg> sendPasswordReset(String accountIdentifier,
      String accountIdentifierType, String token, String newPassword);
}

class AuthRepository implements AuthRepositoryService{
  AuthRepository();
  AuthCredentials anonymous = AuthCredentials(
      username: 'anonymous',
      user: User(id: Uuid().v4().toString(),
          username: 'anonymous',
          password: 'anonymous',
          telephoneNumber: 'anonymous',
          accessToken: 'anonymous')
  );

  String url  = "http://157.230.227.3";
  String guestEndPoint = "/api/v1/guest";
  String registerEndPoint = "/api/v1/user/profile/";
  String loginEndPoint = "/api/v1/user/login/";
  String districtsEndPoint = "/api/v1/districts";
  String regionsEndPoint = "/api/v1/regions";
  String reportersEndPoint = "/api/v1/reporters";
  String deRegisterEndPoint = "/api/v1/user/deregister/";

  ///Login with username
  @override
  Future<User> login(String username, String password) async {
    final response = await HttpUtils.postRequest<Map<String, dynamic>>(
        url + loginEndPoint, {"username": username, "password": password});
    if (response.statusCode == 200) {
      var r = JsonMapper.deserialize<Map>(response.body);

      return new User(
          id: Uuid().v4().toString(),
          username: username,
          password: password,
          telephoneNumber: username,
          accessToken: r['access'],
          district: null,
      );
    } else if (response.statusCode == 401) {
      throw UnauthorisedException("Wrong Credentials");
    } else {
      throw UnknownResponseException("Something is wrong");
    }
  }

  ///Sends verification token entered
  ///takes in the  verification [token]  and the source where it was entered
  ///eg loginForm widget, withdrawalRequest, password reset etc,
  ///Return map of data
  ///[code: 200, msg: "Security Code Is Valid", item: [lastName: "", firstName: "", email: "", phoneNumber: ""]]
  Future<Map> sendVerifyToken(String token, [String source]) async {
    final response = await HttpUtils.postRequest<Map<String, dynamic>>(
        "${url + guestEndPoint}/verification/verify-token",
        {"token": token, "source": source},
        false);
    return JsonMapper.deserialize<Map>(response.body);
  }


  Future<void> storeLoggedInUser(User user) async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    await storage.delete(key: HttpUtils.keyForJWTToken);
    await storage.write(key: HttpUtils.keyForJWTToken, value: user.accessToken);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(HttpUtils.keyForUsername, user.username);
    await preferences.setString(
        HttpUtils.keyForUserJson, JsonMapper.serialize(user));
    await preferences.setString(HttpUtils.keyForJWTToken, user.accessToken);
  }

  ///Delete the store keys from storage
  @override
  Future<void> logout() async {
    FlutterSecureStorage storage = new FlutterSecureStorage();
    await storage.delete(key: HttpUtils.keyForJWTToken);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.remove(HttpUtils.keyForJWTToken);
    await preferences.remove(HttpUtils.keyForUserJson);
    await preferences.remove(HttpUtils.keyForUsername);
  }

  ///Return tru if the current user token from local storage
  Future<bool> hasToken() async {
    try {
      FlutterSecureStorage storage = new FlutterSecureStorage();
      String jwt = await storage.read(key: HttpUtils.keyForJWTToken);
      return jwt != null;
    } catch (e) {
      return false;
    }
  }

  ///Return the current user token from local storage
  @override
  Future<String> getCurrentUserToken() async {
    try {
      FlutterSecureStorage storage = new FlutterSecureStorage();
      String jwt = await storage.read(key: HttpUtils.keyForJWTToken);
      return jwt;
    } catch (e) {
      return null;
    }
  }
  ///Return the current user token from local storage
  Future<User> getCurrentLoggedInUser() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String userJson = preferences.getString(HttpUtils.keyForUserJson);
      var user = JsonMapper.deserialize<User>(userJson);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }


  Future<void> downloadDistricts() async {
    final response = await HttpUtils.getRequest(url + districtsEndPoint);
    List<District> districts = [];

    if (response.statusCode == 200) {
      FlutterSecureStorage storage = new FlutterSecureStorage();
      await storage.write(key: HttpUtils.keyForDistricts, value: response.body);

      JsonMapper.deserialize<List>(response.body).forEach((it) {
        districts.add(new District(id: it['id'], name: it['name'], code: it['code'], region: Region(id: it['region'])));
      });

    } else if (response.statusCode == 401) {
      throw UnauthorisedException("Wrong Credentials");
    } else {
      throw Exception('Failed to load districts');
    }
  }

  Future<void> downloadRegions() async {
    final response = await HttpUtils.getRequest(url + regionsEndPoint);
    List<Region> regions = [];

    if (response.statusCode == 200) {
      FlutterSecureStorage storage = new FlutterSecureStorage();
      await storage.write(key: HttpUtils.keyForRegions, value: response.body);

      JsonMapper.deserialize<List>(response.body).forEach((it) {
        regions.add(new Region(id: it['id'], name: it['name'], code: it['code']));
      });

    } else if (response.statusCode == 401) {
      throw UnauthorisedException("Wrong Credentials");
    } else {
      throw Exception('Failed to load districts');
    }
  }

  @override
  Future<HttpMsg> sendPasswordReset(String accountIdentifier, String accountIdentifierType, String token, String newPassword) {
    // TODO: implement sendPasswordReset
    throw UnimplementedError();
  }

  Future<String> register({String phonenumber, String password, String firstname, String secondname, String region, String district}) async {
    DateTime now = DateTime.now();
    final response = await HttpUtils.postRequest<Map<String, dynamic>>(
        url + registerEndPoint,
        {
          "username": phonenumber,
          "password": password,
          "reporter": {
            "name": firstname + secondname,
            "telephone": phonenumber,
            "registration_date": DateFormat("yyyy-MM-dd'T'HH:mm").format(now),
            "district_id": "2184e494-d695-4d94-9f33-7107a32dee24"  //kampala district id
          }
        }
        );
    if (response.statusCode == 200) {
      FlutterSecureStorage storage = new FlutterSecureStorage();
      await storage.write(key: HttpUtils.keyForUsername, value: phonenumber);
      return "Reporter registered";
    } else {
      throw UnknownResponseException("Something is wrong");
    }
  }

  Future<String> deRegisterReporter({@required String username, @required String password}) async {
    final response = await HttpUtils.postRequest<Map<String, dynamic>>(
        url + deRegisterEndPoint,
        {
          "username": username,
          "password": password,
        }
    );

    if (response.statusCode == 200) {
      return "Success!";
    } else {
      throw Exception('Failed!');
    }
  }
}
