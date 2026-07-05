import 'package:supabase_flutter/supabase_flutter.dart';

class InvalidCredentialException implements Exception {}

class InvalidEmailException implements Exception {}

// signup Exceptions

class EmailAlreadyInuseException implements Exception {}

class WeakPasswordException implements Exception {}

//Generial Exception

class GerneralException implements Exception {}

//  log out

class CouldntLogoutException implements Exception {}

class AuthService {
  Future<AuthResponse> login(String email, String password) async {
    try {
      final authResponse = await Supabase.instance.client.auth
          .signInWithPassword(email: email, password: password);

      return authResponse;
    } on AuthException catch (e) {
      final message = e.message.toLowerCase();
      if (message.contains('invalid login credential')) {
        throw InvalidCredentialException();
      } else if (message.contains('email')) {
        throw InvalidEmailException();
      } else {
        throw GerneralException();
      }
    }
  }

  Future<AuthResponse> register(String email, String password) async {
    try {
      final authResponse = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      return authResponse;
    } on AuthException catch (e) {
      print('supabase Error : Deteail: ${e.message}');
      final message = e.message.toLowerCase();
      if (message.contains('already registered') ||
          message.contains('registered')) {
        throw EmailAlreadyInuseException();
      } else if (message.contains('password')) {
        throw WeakPasswordException();
      } else if (message.contains('email')) {
        throw InvalidEmailException();
      } else {
        throw GerneralException();
      }
    } catch (e) {
      print('unknown error: $e');
    }
    throw GerneralException();
  }

  Future<void> logout() async {
    try {
      await Supabase.instance.client.auth.signOut();
    } catch (e) {
      throw CouldntLogoutException();
    }
  }
}
