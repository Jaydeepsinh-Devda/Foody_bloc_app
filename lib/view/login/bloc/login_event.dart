import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
  @override
  List<Object?> get props => [];
}

class LoginButtonClickEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonClickEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
