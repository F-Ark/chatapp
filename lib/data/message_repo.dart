import 'package:chatapp/domain/message_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'message_repo.g.dart';

class MessagesRepo {
  MessagesRepo(this._dbRef);

  final DatabaseReference _dbRef;

  /// Giriş yapan kullanıcının sohbet kişi listesini Stream olarak döner
  Stream<List<MessageModel>> getUsersChatFriendsStream(String separateUid) {
    return _dbRef.child(separateUid).orderByChild('timestamp').onValue.map(
      (event) {
        if (event.snapshot.value != null && event.snapshot.value is Map) {
          return event.snapshot.children.map(
            (child) {
              return MessageModel.fromJson(
                child.value! as Map<Object?, Object?>,
              );
            },
          ).toList();
        } else {
          return <MessageModel>[];
        }
      },
    );
  }

  Future<void> sendMessage(String separateUid, MessageModel message) async {
    await _dbRef.child(separateUid).push().update(message.toJson());

  }
}

@riverpod
MessagesRepo realTimeMessageRepo(Ref ref) {
  return MessagesRepo(FirebaseDatabase.instance.ref('/chatapp/messages/'));
}
