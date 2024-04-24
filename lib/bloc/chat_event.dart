// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class ChatInitialEvent extends ChatEvent {}

class ChatGenerateNewMsgEvent extends ChatEvent {
  final String inputMsg;

  ChatGenerateNewMsgEvent({required this.inputMsg});
}

class PickImageEvent extends ChatEvent {}
