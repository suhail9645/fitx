part of 'message_bloc.dart';

abstract class MessageState {}

class MessageInitial extends MessageState {}
class MessageInitialState extends MessageState{
  final WebSocketChannel channel;

  MessageInitialState({required this.channel});
}