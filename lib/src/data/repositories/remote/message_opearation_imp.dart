import 'dart:convert';

import 'package:either_dart/src/either.dart';
import 'package:fitx/main.dart';
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:fitx/src/domain/model/message_result/message_result.dart';
import 'package:fitx/src/domain/repo/message_operations.dart';
import 'package:fitx/src/presentation/views/category_add_screen/category_add_barell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class MessageOperationsImp extends MessageOperations {
  @override
  Future<void> sendTextMessage(
      int recieverId, String message, WebSocketChannel socket) async {
    try {
      socket.sink.add( jsonEncode({
        "type": "message",
        "message": {"type": "text", "text": message, "receiver_id": recieverId}
      }));
    } catch (e) {
      return;
    }
  }

  @override
  Stream<Either<ErrorModel, MessageResult>> recieveMessage(
      WebSocketChannel socket) async* {
    try {
      List<MessageResult> messages = [];
      final message = socket.stream.listen((message) {});
      message.onData((data) {
        MessageResult messageResult = MessageResult.fromJson(data);
        messages.add(messageResult);
      });
      for (var element in messages) {
        yield Right(element);
      }
    } catch (e) {
      yield Left(ErrorModel(e.toString()));
    }
  }
}
