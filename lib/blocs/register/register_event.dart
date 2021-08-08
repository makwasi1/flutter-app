abstract class RegisterEvent{}

class RegisterPhoneNumberChanged extends RegisterEvent {
  final String phonenumber;

  RegisterPhoneNumberChanged({this.phonenumber});
}

class RegisterFirstNameChanged extends RegisterEvent {
  final String firstname;

  RegisterFirstNameChanged({this.firstname});
}

class RegisterSecondNameChanged extends RegisterEvent {
  final String secondname;

  RegisterSecondNameChanged({this.secondname});
}

class RegisterRegionChanged extends RegisterEvent {
  final String region;

  RegisterRegionChanged({this.region});
}

class RegisterDistrictChanged extends RegisterEvent {
  final String district;

  RegisterDistrictChanged({this.district});
}

class RegisterSubmitted extends RegisterEvent {}
