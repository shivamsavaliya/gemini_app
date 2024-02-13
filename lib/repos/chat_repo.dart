import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gemini_app/models/chat_msg_model.dart';
import 'package:gemini_app/models/chat_res_model.dart';
import 'package:gemini_app/utils/constants.dart';

class ChatRepo {
  static Future<ChatResponseModel?> chatTextGenerationRepo(
      List<ChatMsgModel> msgs) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=$apiKey",
          data: {
            "contents": msgs.map((e) => e.toMap()).toList(),
            "generationConfig": {
              "temperature": 0.9,
              "topK": 1,
              "topP": 1,
              "maxOutputTokens": 2048,
              "stopSequences": []
            },
            "safetySettings": [
              {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_HATE_SPEECH",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              }
            ]
          });
      ChatResponseModel modelData = ChatResponseModel.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        return modelData;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
