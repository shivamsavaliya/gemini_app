import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:gemini_app/models/chat_msg_model.dart';
import 'package:gemini_app/models/chat_res_model.dart';
import 'package:gemini_app/repos/chat_repo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitialState()) {
    on<ChatInitialEvent>(chatInitialEvent);
    on<ChatGenerateNewMsgEvent>(chatGenerateNewMsgEvent);
    on<PickImageEvent>(pickImageEvent);
  }

  List<ChatMsgModel> msgs = [];
  bool loading = false;
  final ImagePicker picker = ImagePicker();
  XFile? image;

  FutureOr<void> chatInitialEvent(
      ChatInitialEvent event, Emitter<ChatState> emit) {
    emit(ChatSuccessState(msgs: msgs));
  }

  FutureOr<void> chatGenerateNewMsgEvent(
      ChatGenerateNewMsgEvent event, Emitter<ChatState> emit) async {
    msgs.add(ChatMsgModel(
        role: "user", parts: [ChartPartModel(text: event.inputMsg)]));
    emit(ChatSuccessState(msgs: msgs));
    loading = true;
    ChatResponseModel? generateContent =
        await ChatRepo.chatTextGenerationRepo(msgs);
    if (generateContent!.candidates!.isNotEmpty) {
      msgs.add(ChatMsgModel(role: 'model', parts: [
        ChartPartModel(
            text: generateContent.candidates!.first.content!.parts!.first.text!)
      ]));
      emit(ChatSuccessState(msgs: msgs));
    }
    loading = false;
  }

  FutureOr<void> pickImageEvent(
      PickImageEvent event, Emitter<ChatState> emit) async {
    image = (await picker.pickImage(source: ImageSource.gallery))!;
    if (image!.path.isNotEmpty) {
      log(image!.name.toString());
      emit(ImagePickedSuccessState());
    }
  }
}
