import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fitx/src/presentation/views/category_add_screen/category_add_barell.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  MessageBloc() : super(MessageInitial()) {
    on<TextSentEvent>(textSentEvent);
    on<MessageInitialEvent>(messageInitialEvent);
  }

  Future<void> textSentEvent(
      TextSentEvent event, Emitter<MessageState> emit) async {}

  Future<void> messageInitialEvent(MessageInitialEvent event, Emitter<MessageState> emit)async {
    SharedPreferences shrd=await SharedPreferences.getInstance();
    String access=shrd.getString('access')!;
    WebSocketChannel channel = WebSocketChannel.connect(Uri.parse('ws://192.168.43.130:8000/ws/messages/?token=$access'));
    
    emit(MessageInitialState(channel: channel));
  }
}
