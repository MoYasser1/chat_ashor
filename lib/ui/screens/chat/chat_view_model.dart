
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../database_utils/database_utils.dart';
import '../../../models/message_model.dart';
import '../../../models/room_model.dart';
import '../base.dart';
import 'chat_navigator.dart';

class ChatViewModel extends BaseViewModel<ChatNavigator> {
  late Room room;
  //late MyUser myUser;


  void sendMessage(String content) {
    if (content.trim().isEmpty) return;
    Message message = Message(
        content: content,
        dateTime: DateTime.now().millisecondsSinceEpoch,
        senderId: FirebaseAuth.instance.currentUser!.uid,
        senderName: FirebaseAuth.instance.currentUser!.email??'',
        roomId: room.id);
    DataBaseUtils.addMessageToFirestore(message).then((value) {
      navigator!.clearMessage();
    }).catchError((error) {
      navigator!.showMessage(error.toString());
    });
  }

  Stream<QuerySnapshot<Message>> getMessages() {
    return DataBaseUtils.readMessagesFromFirestore(room.id);
  }
}