import 'package:chatapp/domain/friend_model.dart';
import 'package:chatapp/domain/user_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repo.g.dart';

/// Firebase RealTimeDataBase sorgu ve veri ekleme işlemlerini içerir
class UsersRepo {
  UsersRepo(this._dbRef);

  final DatabaseReference _dbRef;

  /// Giriş yapan kullanıcı ilk kez giriş yapıyorsa Db'ye eklenir.
  Future<void> createUserIfNotExist(UserModel? user) async {
    final uid = user?.uid;

    if (uid == null) {
      throw Exception('Kullanıcı bilgisi alınamadı');
    } else {
      final event = await _dbRef.child(uid).once();
      if (event.snapshot.value == null) {
        final json = user!.toJson();
        await _dbRef.child(uid).update(json);
      }
    }
  }

  /// Giriş yapan kullanıcının sohbet kişi listesini Stream olarak döner
  Stream<List<FriendModel>> getUsersChatFriendsStream(UserModel? user) {
    final uid = user?.uid;
    if (uid == null) {
      throw Exception('Kullanıcı bilgisi alınamadı');
    }

    return _dbRef
        .child(uid)
        .child('friends')
        .orderByChild('timestamp')
        .onValue
        .map(
      (event) {
        if (event.snapshot.value != null && event.snapshot.value is Map) {
          return event.snapshot.children.map(
            (child) {
              return FriendModel.fromJson(
                child.value! as Map<Object?, Object?>,
              );
            },
          ).toList();
        } else {
          return <FriendModel>[];
        }
      },
    );
  }

  /// Databasedeki tüm kullanıcıları tek seferlik listeler
  Future<List<UserModel>> getAllUsers() async {
    final event = await _dbRef.orderByChild('username').once();
    if (event.snapshot.value != null && event.snapshot.value is Map) {
      return event.snapshot.children.map(
        (child) {
          return UserModel.fromJson(child.value! as Map<Object?, Object?>);
        },
      ).toList();
    } else {
      return <UserModel>[];
    }
  }

  /// Databasedeki karşı kullanıcıyı tek serferlik çeker
  Future<UserModel?> getSpesificUser(String otherUserId) async {
    final event = await _dbRef.child(otherUserId).once();
    if (event.snapshot.value != null && event.snapshot.value is Map) {
      return UserModel.fromJson(event.snapshot.value! as Map<Object?, Object?>);
    } else {
      return null;
    }
  }

  Future<void> addFriend(FriendModel friend, String currentUserId) async {
    final json = friend.toJson();
    await _dbRef
        .child(currentUserId)
        .child('friends')
        .child(friend.uid)
        .update(json);
  }

  Future<void> updateOtherUsersLastMessage({
    required String otherUserId,
    required String messageText,
    required String currentUserId,
  }) async {
    await _dbRef
        .child(otherUserId)
        .child('friends')
        .child(currentUserId)
        .update({'lastMessage': messageText});
  }
}

@riverpod
UsersRepo realTimeUsersRepo(Ref ref) {
  return UsersRepo(FirebaseDatabase.instance.ref('/chatapp/Users/'));
}

@riverpod
Future<UserModel?> getSpesificUser(Ref ref, String otherUserId) {
  return ref.read(realTimeUsersRepoProvider).getSpesificUser(otherUserId);
}
