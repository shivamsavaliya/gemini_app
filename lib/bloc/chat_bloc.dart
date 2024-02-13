import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:gemini_app/models/chat_msg_model.dart';
import 'package:gemini_app/models/chat_res_model.dart';
import 'package:gemini_app/repos/chat_repo.dart';
import 'package:meta/meta.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(msgs: const [])) {
    on<ChatGenerateNewMsgEvent>(chatGenerateNewMsgEvent);
  }
  List<ChatMsgModel> msgs = [];
  bool loading = false;
  FutureOr<void> chatGenerateNewMsgEvent(
      ChatGenerateNewMsgEvent event, Emitter<ChatState> emit) async {
    msgs.add(ChatMsgModel(
        role: "user", parts: [ChartPartModel(text: event.inputMsg)]));
    emit(ChatSuccessState(msgs: msgs));
    loading = true;
    ChatResponseModel? generateContent =
        await ChatRepo.chatTextGenerationRepo(msgs);
    if (generateContent!.candidates.isNotEmpty) {
      msgs.add(ChatMsgModel(role: 'model', parts: [
        ChartPartModel(
            text: generateContent.candidates.first.content.parts.first.text)
      ]));
      emit(ChatSuccessState(msgs: msgs));
    }
    loading = false;
  }
}
