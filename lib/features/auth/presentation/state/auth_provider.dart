import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_app/core/core.dart';
import 'package:flutter_chat_app/features/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider({required this.dataSource}) : super(const AuthStateInitial());

  final AuthDataSource dataSource;

  Future<void> login({required String email, required String password}) async {
    state = const AuthStateLoading();
    final response = await dataSource.login(email: email, password: password);
    state = response.fold(
      (error) => AuthStateError(error),
      (response) {
        updateUserDB(response);
        return AuthStateSuccess(user: response!);
      },
    );
  }

  Future<void> signup({required String email, required String password}) async {
    state = const AuthStateLoading();
    final response = await dataSource.signup(email: email, password: password);
    state = response.fold(
      (error) => AuthStateError(error),
      (response) {
        updateUserDB(response);
        return AuthStateSuccess(user: response);
      },
    );
  }

  Future<void> signOut() async {
    state = const AuthStateLoading();
    final response = await dataSource.signOut();
    state = response.fold(
      (error) => AuthStateError(error),
      (response) {
        var _user = injector<FirebaseAuthService>().getAuth.currentUser;
        updateUserDB(_user, isActive: false);
        return const AuthStateSignOutSuccess();
      },
    );
  }

  updateUserDB(User? user, {bool? isActive}) async {
    var db = injector<FirebaseDbService>();
    var userModel = UserModel(
        uid: user!.uid, email: user.email, is_active: isActive ?? true);
    await db.getUsersCollection?.doc(userModel.uid).set(userModel);
  }
}

final authNotifierProvider = StateNotifierProvider<AuthProvider, AuthState>(
  (ref) => AuthProvider(dataSource: ref.read(authDataSourceProvider)),
);
