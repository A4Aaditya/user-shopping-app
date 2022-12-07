import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _instance = FirebaseAuth.instance;

  Future<User?> signinWithEmailAndPassword(
      String email, String password) async {
    try {
      final auth = await _instance.signInWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signupWithEmailAndPassword(
      String email, String password) async {
    try {
      final auth = await _instance.createUserWithEmailAndPassword(
          email: email, password: password);
      return auth.user;
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signout() async {
    try {
      await _instance.signOut();
    } on FirebaseException catch (e) {
      throw e.message.toString();
    } catch (e) {
      rethrow;
    }
  }
}
