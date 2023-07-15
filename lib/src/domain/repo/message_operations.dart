import 'package:either_dart/either.dart';
import 'package:fitx/src/domain/model/error/error.dart';
import 'package:fitx/src/domain/model/message_result/message_result.dart';
import 'package:fitx/src/presentation/views/category_add_screen/category_add_barell.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class MessageOperations {
  Future<void> sendTextMessage(
      int recieverId, String message, WebSocketChannel socket);
  Stream<Either<ErrorModel,MessageResult>>recieveMessage(WebSocketChannel socket);
}
