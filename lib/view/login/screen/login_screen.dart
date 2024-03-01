import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foody_bloc_app/constants/strings.dart';
import 'package:foody_bloc_app/ui_components/custom_button.dart';
import 'package:foody_bloc_app/view/login/bloc/login_bloc.dart';
import 'package:foody_bloc_app/view/login/bloc/login_event.dart';
import 'package:foody_bloc_app/view/login/bloc/login_state.dart';
import 'package:foody_bloc_app/view/login/utility.dart';
import 'package:foody_bloc_app/view/login/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  static String tag = "/login-screen";
  const LoginScreen({super.key});

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
                Navigator.pushNamed(context, LoginScreen.tag);
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _signInAndWelcomeText(),
                  _loginForm(state),
                  CustomButton(
                    text: state is OnLoginLoadingState
                        ? const CircularProgressIndicator(
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
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  //! Widget Methods
  Widget _loginForm(LoginState state) => Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              textFieldName: FoodyAppStrings.kEmail,
              validator: Utility.emailValidation,
              controller: _emailController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              textFieldName: FoodyAppStrings.kPassword,
              validator: Utility.passwordValidation,
              obscureText: true,
              controller: _passwordController,
            ),
          ],
        ),
      );

  Widget _signInAndWelcomeText() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            FoodyAppStrings.kSignIn,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(FoodyAppStrings.kSignInWelcomeText),
        ],
      );

  Widget _loadingIndicator() => const CircularProgressIndicator(
        color: Colors.white,
      );
}
