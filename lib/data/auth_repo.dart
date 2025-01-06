import 'dart:async';

import 'package:chatapp/domain/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repo.g.dart';

/// Kullanıcının oturum bilgisini [FirebaseAuth] ile yönetir
class FirabaseAuthRepo {
  FirabaseAuthRepo(this._firebaseAuthIstance);

  final FirebaseAuth _firebaseAuthIstance;

  Stream<bool> get isCurrentUserSingInStream =>
      _firebaseAuthIstance.authStateChanges().map(
            (user) => user != null,
          );



  bool get isCurrentUserSingIn {
    return _user != null;
  }

  User? get _user => _firebaseAuthIstance.currentUser;

  UserModel? get currentUsertoUserModelWithOutFriends {
    if (isCurrentUserSingIn) {
      return UserModel(
        uid: _user!.uid,
        eposta: _user!.email,
        username: _user!.displayName,
      );
    } else {
      return null;
    }
  }

  Future<void> signInWithGoogle() async {
    // Kimlik doğrulama akışını tetikleyin
    final googleUser = await GoogleSignIn().signIn();

    // Kimlik doğrulama ayrıntılarını istekten alın
    final googleAuth = await googleUser?.authentication;

    // Yeni bir kimlik bilgisi oluştur
    final kimlik = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _firebaseAuthIstance.signInWithCredential(kimlik);
  }

  Future<void> signOut() async {
    await _firebaseAuthIstance.signOut();
  }
}

@Riverpod(keepAlive: true)
FirabaseAuthRepo auth(Ref ref) {
  return FirabaseAuthRepo(FirebaseAuth.instance);
}
