import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/ui_components/custom_button.dart';
import 'package:foody_bloc_app/view/bottom_navigation/screen/custom_bottom_navigation_screen.dart';
import 'package:foody_bloc_app/view/login/bloc/login_bloc.dart';
import 'package:foody_bloc_app/view/login/bloc/login_event.dart';
import 'package:foody_bloc_app/view/login/bloc/login_state.dart';
import 'package:foody_bloc_app/ui_components/loading_indicator.dart';
import 'package:foody_bloc_app/view/login/utility.dart';
import 'package:foody_bloc_app/view/login/widget/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static String tag = "/login-screen";
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late LoginBloc _bloc;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _bloc = context.read<LoginBloc>();
    super.initState();
  }

  //! Build Method
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state is OnLoginSuccessState) {
                Navigator.pushNamed(
                    context, CustomBottomNavigationBarScreen.tag);
              }
              if (state is OnLoginFailureState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Wrong Credentials"),
                  ),
                );
              }
            },
            builder: (context, state) {
              return _loginScreen(state);
            },
          ),
        ),
      ),
    );
  }

//! Widget Methods
  Widget _loginScreen(LoginState state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _signInAndWelcomeText(),
          _loginForm(state),
          _loginButton(state)
        ],
      );

  Widget _loginForm(LoginState state) => Form(
        key: _formKey,
        child: Column(
          children: [
            _emailTextField(),
            const SizedBox(height: 20),
            _passwordTextField(),
          ],
        ),
      );

  Widget _emailTextField() => CustomTextField(
        textFieldName: FoodyAppStrings.kEmail,
        validator: Utility.emailValidation,
        controller: _emailController,
      );

  Widget _passwordTextField() => CustomTextField(
        textFieldName: FoodyAppStrings.kPassword,
        validator: Utility.passwordValidation,
        obscureText: true,
        controller: _passwordController,
      );

  Widget _signInAndWelcomeText() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _signInText(),
          _welcomeText(),
        ],
      );
  Widget _signInText() => Text(
        FoodyAppStrings.kSignIn,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      );

  Widget _welcomeText() => Text(FoodyAppStrings.kSignInWelcomeText);

  Widget _loginButton(LoginState state) => CustomButton(
        text: state is OnLoginLoadingState
            ? const LoadingIndicator(
                color: Colors.white,
              )
            : Text(FoodyAppStrings.kLogin),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _bloc.add(
              LoginButtonClickEvent(
                email: _emailController.text,
                password: _passwordController.text,
              ),
            );
          }
        },
      );
}
