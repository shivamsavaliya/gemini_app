// To parse this JSON data, do
//
//     final imageMsgModel = imageMsgModelFromJson(jsonString);

import 'dart:convert';

ImageMsgModel imageMsgModelFromJson(String str) =>
    ImageMsgModel.fromJson(json.decode(str));

String imageMsgModelToJson(ImageMsgModel data) => json.encode(data.toJson());

class ImageMsgModel {
  final List<Content> contents;
  final GenerationConfig generationConfig;
  final List<SafetySetting> safetySettings;

  ImageMsgModel({
    required this.contents,
    required this.generationConfig,
    required this.safetySettings,
  });

  factory ImageMsgModel.fromJson(Map<String, dynamic> json) => ImageMsgModel(
        contents: List<Content>.from(
            json["contents"].map((x) => Content.fromJson(x))),
        generationConfig: GenerationConfig.fromJson(json["generationConfig"]),
        safetySettings: List<SafetySetting>.from(
            json["safetySettings"].map((x) => SafetySetting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
        "generationConfig": generationConfig.toJson(),
        "safetySettings":
            List<dynamic>.from(safetySettings.map((x) => x.toJson())),
      };
}

class Content {
  final List<Part> parts;

  Content({
    required this.parts,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        parts: List<Part>.from(json["parts"].map((x) => Part.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
      };
}

class Part {
  final InlineData? inlineData;
  final String? text;

  Part({
    this.inlineData,
    this.text,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        inlineData: json["inlineData"] == null
            ? null
            : InlineData.fromJson(json["inlineData"]),
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "inlineData": inlineData?.toJson(),
        "text": text,
      };
}

class InlineData {
  final String mimeType;
  final String data;

  InlineData({
    required this.mimeType,
    required this.data,
  });

  factory InlineData.fromJson(Map<String, dynamic> json) => InlineData(
        mimeType: json["mimeType"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "mimeType": mimeType,
        "data": data,
      };
}

class GenerationConfig {
  final double temperature;
  final int topK;
  final int topP;
  final int maxOutputTokens;
  final List<dynamic> stopSequences;

  GenerationConfig({
    required this.temperature,
    required this.topK,
    required this.topP,
    required this.maxOutputTokens,
    required this.stopSequences,
  });

  factory GenerationConfig.fromJson(Map<String, dynamic> json) =>
      GenerationConfig(
        temperature: json["temperature"]?.toDouble(),
        topK: json["topK"],
        topP: json["topP"],
        maxOutputTokens: json["maxOutputTokens"],
        stopSequences: List<dynamic>.from(json["stopSequences"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "temperature": temperature,
        "topK": topK,
        "topP": topP,
        "maxOutputTokens": maxOutputTokens,
        "stopSequences": List<dynamic>.from(stopSequences.map((x) => x)),
      };
}

class SafetySetting {
  final String category;
  final String threshold;

  SafetySetting({
    required this.category,
    required this.threshold,
  });

  factory SafetySetting.fromJson(Map<String, dynamic> json) => SafetySetting(
        category: json["category"],
        threshold: json["threshold"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "threshold": threshold,
      };
}
