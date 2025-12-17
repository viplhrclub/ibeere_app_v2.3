import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../api_service.dart';

/// Auth state definitions
sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class Authenticated extends AuthState {
  final Map<String, dynamic> authModel;
  const Authenticated(this.authModel);
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}

/// Auth Cubit for managing authentication state
class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(const AuthInitial());

  Future<void> updateAuthDetails({
    required String firebaseId,
    required String authProvider,
    required bool authStatus,
    required bool isNewUser,
  }) async {
    try {
      emit(const AuthLoading());
      
      final result = await ApiService.signIn(
        email: firebaseId,
        password: firebaseId, // In real app, use actual password
      );
      
      if (result['success']) {
        final userProfile = await ApiService.getUserProfile(result['uid']);
        
        final authModel = {
          'uid': result['uid'],
          'email': firebaseId,
          'authProvider': authProvider,
          'authStatus': authStatus,
          'isNewUser': isNewUser,
          'profile': userProfile,
        };
        
        emit(Authenticated(authModel));
      } else {
        emit(AuthError(result['error'] ?? 'Authentication failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      emit(const AuthLoading());
      
      final result = await ApiService.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );
      
      if (result['success']) {
        final userProfile = await ApiService.getUserProfile(result['uid']);
        
        final authModel = {
          'uid': result['uid'],
          'email': email,
          'fullName': fullName,
          'profile': userProfile,
        };
        
        emit(Authenticated(authModel));
      } else {
        emit(AuthError(result['error'] ?? 'Sign up failed'));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> checkAuthStatus() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      
      if (currentUser != null) {
        final userProfile = await ApiService.getUserProfile(currentUser.uid);
        
        final authModel = {
          'uid': currentUser.uid,
          'email': currentUser.email,
          'profile': userProfile,
        };
        
        emit(Authenticated(authModel));
      } else {
        emit(const Unauthenticated());
      }
    } catch (e) {
      emit(const Unauthenticated());
    }
  }

  Future<void> logoutOrDeleteAccount({bool deleteAccount = false}) async {
    try {
      if (deleteAccount) {
        await FirebaseAuth.instance.currentUser?.delete();
      } else {
        await FirebaseAuth.instance.signOut();
      }
      emit(const Unauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  bool get isLoggedIn => state is Authenticated;
  bool get isGuest => state is Unauthenticated;
}
