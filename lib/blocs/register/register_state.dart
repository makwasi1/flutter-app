import '../form_submission_status.dart';

class RegisterState {
  final String phonenumber;
  bool get isValidPhoneNumber => phonenumber.length > 9;

  final String password;
  bool get isValidPassword => password.length > 1;

  final String firstname;
  bool get isValidFirstName => firstname.length > 1;

  final String secondname;
  bool get isValidSecondName => secondname.length > 1;

  final String region;
  bool get isValidRegion => region.length > 1;

  final String district;
  bool get isValidDistrict => district.length > 1;

  final FormSubmissionStatus formStatus;

  RegisterState({
    this.phonenumber = '',
    this.password = '',
    this.firstname = '',
    this.secondname = '',
    this.region = '',
    this.district = '',
    this.formStatus = const InitialFormStatus(),
  });

  RegisterState copyWith({
    String phonenumber,
    String password,
    String firstname,
    String secondname,
    String region,
    String district,
    FormSubmissionStatus formStatus,
  }) {
    return RegisterState(
      phonenumber: phonenumber ?? this.phonenumber,
      password: password ?? this.password,
      firstname: firstname ?? this.firstname,
      secondname: secondname ?? this.secondname,
      region: region ?? this.region,
      district: district ?? this.district,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
