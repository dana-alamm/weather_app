import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/services/shared_prefs_service.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _auth.authStateChanges();// if the user login or sign out
  User? get currentUser => _auth.currentUser;

  Future<UserCredential> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String dob,
    required String fullPhoneNumber,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password,
          );

      final String uid = userCredential.user!.uid;
      await _firestore.collection('users').doc(uid).set({
        'uid': uid,
        'firstName': firstName.trim(),
        'lastName': lastName.trim(),
        'email': email.trim(),
        'dob': dob.trim(),
        'phone': fullPhoneNumber.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      await SharedPrefsService.saveData(key: 'isLoggedIn', value: true);
      await SharedPrefsService.saveData(key: 'uId', value: uid);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<UserCredential> logIn({
    required String email,
    required String password,
  }) async {
    try {
     final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await SharedPrefsService.saveData(key: 'isLoggedIn', value: true);
      await SharedPrefsService.saveData(key: 'uId', value: userCredential.user!.uid);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected error occurred. Please try again.';
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(//change form googleKey to firebase key
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final User? user = userCredential.user;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'email': user.email ?? '',
          'firstName': user.displayName?.split(' ').first ?? '',
          'lastName': user.displayName?.split(' ').skip(1).join(' ') ?? '',
          'createdAt': FieldValue.serverTimestamp(),
        }, SetOptions(merge: true));
        await SharedPrefsService.saveData(key: 'isLoggedIn', value: true);
        await SharedPrefsService.saveData(key: 'uId', value: user.uid);
      }
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    await SharedPrefsService.removeData(key: 'isLoggedIn');
    await SharedPrefsService.removeData(key: 'uId');
  }

  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email address is already registered.';
      case 'invalid-email':
        return 'The email address is badly formatted.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'network-request-failed':
        return 'Please check your internet connection.';
      default:
        return e.message ?? 'An error occurred. Please try again.';
    }
  }
}
