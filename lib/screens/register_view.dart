import 'package:citizen_feedback/blocs/auth/auth_bloc.dart';
import 'package:citizen_feedback/blocs/form_submission_status.dart';
import 'package:citizen_feedback/blocs/internet/internet_bloc.dart';
import 'package:citizen_feedback/blocs/register/register_event.dart';
import 'package:citizen_feedback/blocs/register/register_state.dart';
import 'package:citizen_feedback/services/http_utils.dart';
import 'package:citizen_feedback/services/sessions/session_cubit.dart';
import 'package:citizen_feedback/shared/utilities.dart';
import 'package:citizen_feedback/theme/theme.dart';
import 'package:citizen_feedback/widgets/dropdown_widget.dart';
import 'package:citizen_feedback/widgets/textfield_decoration.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../blocs/register/register_bloc.dart';
import 'package:citizen_feedback/services/auth_repository.dart';
import 'package:citizen_feedback/widgets/gradient_button.dart';
import 'package:citizen_feedback/widgets/layout_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterView extends StatefulWidget {

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();
  var districts = [];
  var regions = [];
  var _districtsDefault = ["Kampala", "Arua", "Mbale", "Hoima", "Mbarara"];
  var _regionsDefault = ["Central", "Western", "Eastern", "Northern"];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async{
    FlutterSecureStorage storage = new FlutterSecureStorage();
    String storedDistricts = await storage.read(key: HttpUtils.keyForDistricts);
    String storedRegions = await storage.read(key: HttpUtils.keyForRegions);
    var districts = JsonMapper.deserialize<List>(storedDistricts);
    var regions = JsonMapper.deserialize<List>(storedRegions);

    var listOfDistricts = [];
    var listOfRegions = [];

    districts.forEach((element) { listOfDistricts.add(element['name']); });
    regions.forEach((element) { listOfRegions.add(Utilities().humanize(element['name'])); });

    setState(() {
      this.districts = listOfDistricts;
      this.regions = listOfRegions;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: Combination1,
          ),
        ),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          children: <Widget>[
            Stack(
              children: <Widget>[
                LayoutWidget(
                    showBackButton: false,
                    onBackClick: 'showLogin',
                    authBloc: context.read<AuthBloc>()),
                Container(
                  padding: const EdgeInsets.only(top: 200, left: 0),
                  child: BlocProvider(
                    create: (context) => RegisterBloc(
                      authRepo: context.read<AuthRepository>(),
                      authBloc: context.read<AuthBloc>(),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.only(left: 60.0),
                            child: Text(
                              'Register',
                              style: TextStyle(
                                fontSize: LargeTextSize,
                                color: AccentColor,
                                fontFamily: HeadingFont,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        _registerForm(),
                        SizedBox(
                          height: 42,
                        ),
                        _showLoginButton(context),
                        SizedBox(
                          height: 20,
                        ),
                        GradientButton(
                          text: Text(
                            'Skip',
                            style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          colors: CombinationGreen,
                          width: 200,
                          height: 45,
                          onPressed: () {
                            context.read<SessionCubit>().launchSession(AuthRepository().anonymous);
                          },
                        ),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerForm() {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          Utilities().showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _firstNameField(),
              SizedBox(height: 8.0),
              _secondNameField(),
              SizedBox(height: 8.0),
              _phoneNumberField(),
              SizedBox(height: 8.0),
              _regionField(),
              SizedBox(height: 8.0),
              _districtField(),
              SizedBox(
                height: 30,
              ),
              _registerButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstNameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        decoration: TextFieldDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: 'First Name',
        ).draw(),
        validator: (value) =>
            state.isValidFirstName ? null : 'First Name is too short',
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterFirstNameChanged(firstname: value)),
      );
    });
  }

  Widget _secondNameField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        decoration: TextFieldDecoration(
          prefixIcon: Icon(Icons.person),
          hintText: 'Second Name',
        ).draw(),
        validator: (value) =>
            state.isValidSecondName ? null : 'Second Name is too short',
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterSecondNameChanged(secondname: value)),
      );
    });
  }

  Widget _phoneNumberField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return TextFormField(
        decoration: TextFieldDecoration(
          prefixIcon: Icon(Icons.phone),
          hintText: 'Phone Number',
        ).draw(),
        keyboardType: TextInputType.number,
        validator: (value) =>
            state.isValidPhoneNumber ? null : 'Phone Number is too short',
        onChanged: (value) => context
            .read<RegisterBloc>()
            .add(RegisterPhoneNumberChanged(phonenumber: value)),
      );
    });
  }

  Widget _regionField() {
    return DropDownWidget(
      value:  regions != null ? regions : _regionsDefault,
      hintText: 'Select Region',
      icon: Icon(Icons.map),
    );
  }

  Widget _districtField() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return DropDownWidget(
        value: districts != null ? districts : _districtsDefault,
        hintText: 'Select District',
        icon: Icon(Icons.location_pin),
      );
    });
  }

  Widget _registerButton() {
    return BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : GradientButton(
              text: Text(
                'Register',
                style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                Icons.app_registration,
                color: Colors.white,
              ),
              colors: CombinationBlue,
              width: 200,
              height: 45,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  context.read<RegisterBloc>().add(RegisterSubmitted());
                }
              },
            );
    });
  }

  Widget _showLoginButton(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('Already have an account?'),
        SizedBox(
          height: 25,
        ),
        GradientButton(
          text: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.login,
            color: Colors.white,
          ),
          colors: CombinationPink,
          width: 200,
          height: 45,
          onPressed: () => context.read<AuthBloc>().showLogin(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
