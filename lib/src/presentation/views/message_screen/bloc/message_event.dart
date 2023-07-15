part of 'message_bloc.dart';

abstract class MessageEvent {}

class MessageInitialEvent extends MessageEvent {}

class ImageSendEvent extends MessageEvent {
  final int recieverId;
  final WebSocketChannel socket;
  ImageSendEvent({required this.recieverId, required this.socket});
}

class FileSendEvent extends MessageEvent {
  final int recieverId;

  FileSendEvent({required this.recieverId});
}

class TextSentEvent extends MessageEvent {
  final int recieverId;
  final String text;
  final WebSocketChannel socket;
  TextSentEvent(
      {required this.recieverId, required this.text, required this.socket});
}
