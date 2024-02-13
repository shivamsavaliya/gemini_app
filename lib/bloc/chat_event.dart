part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

class ChatGenerateNewMsgEvent extends ChatEvent {
  final String inputMsg;

  ChatGenerateNewMsgEvent({required this.inputMsg});
}
