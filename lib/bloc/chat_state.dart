part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitialState extends ChatState {}

class ChatActionState extends ChatState {}

class ChatSuccessState extends ChatState {
  final List<ChatMsgModel> msgs;
  ChatSuccessState({required this.msgs});
}

class ImagePickedSuccessState extends ChatState {}
