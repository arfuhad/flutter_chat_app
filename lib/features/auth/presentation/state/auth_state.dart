// import 'package:flutter_chat_app/features/auth/auth.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object> get props => [];
}

class AuthStateInitial extends AuthState {
  const AuthStateInitial();

  @override
  List<Object> get props => [];
}

class AuthStateLoading extends AuthState {
  const AuthStateLoading();

  @override
  List<Object> get props => [];
}

class AuthStateSuccess extends AuthState {
  const AuthStateSuccess({required this.user});
  final User user;

  @override
  List<Object> get props => [];
}

class AuthStateSignOutSuccess extends AuthState {
  const AuthStateSignOutSuccess();

  @override
  List<Object> get props => [];
}

class AuthStateError extends AuthState {
  final String error;

  const AuthStateError(this.error);

  @override
  List<Object> get props => [error];
}
