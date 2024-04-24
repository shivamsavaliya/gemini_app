import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:gemini_app/models/image_res_model.dart';
import 'package:gemini_app/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class ImageRepo {
  static Future<ImageResponseModel?> imageTextGenaration(
      List<XFile>? files, String msg) async {
    try {
      Dio dio = Dio();
      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro-vision:generateContent?key=$apiKey",
          data: {
            "contents": [
              {
                "parts": [
                  {
                    "inlineData": {
                      "mimeType": "image/jpeg",
                      "data": files,
                    }
                  },
                  {
                    "text": msg,
                  }
                ]
              }
            ],
            "generationConfig": {
              "temperature": 0.4,
              "topK": 32,
              "topP": 1,
              "maxOutputTokens": 4096,
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
      ImageResponseModel modelData = ImageResponseModel.fromJson(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        log(modelData.toString());
        return modelData;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
