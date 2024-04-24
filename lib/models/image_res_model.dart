// To parse this JSON data, do
//
//     final imageResponseModel = imageResponseModelFromJson(jsonString);

import 'dart:convert';

ImageResponseModel imageResponseModelFromJson(String str) =>
    ImageResponseModel.fromJson(json.decode(str));

String imageResponseModelToJson(ImageResponseModel data) =>
    json.encode(data.toJson());

class ImageResponseModel {
  final List<Candidate> candidates;

  ImageResponseModel({
    required this.candidates,
  });

  factory ImageResponseModel.fromJson(Map<String, dynamic> json) =>
      ImageResponseModel(
        candidates: List<Candidate>.from(
            json["candidates"].map((x) => Candidate.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "candidates": List<dynamic>.from(candidates.map((x) => x.toJson())),
      };
}

class Candidate {
  final Content content;
  final String finishReason;
  final int index;
  final List<SafetyRating> safetyRatings;

  Candidate({
    required this.content,
    required this.finishReason,
    required this.index,
    required this.safetyRatings,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) => Candidate(
        content: Content.fromJson(json["content"]),
        finishReason: json["finishReason"],
        index: json["index"],
        safetyRatings: List<SafetyRating>.from(
            json["safetyRatings"].map((x) => SafetyRating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "content": content.toJson(),
        "finishReason": finishReason,
        "index": index,
        "safetyRatings":
            List<dynamic>.from(safetyRatings.map((x) => x.toJson())),
      };
}

class Content {
  final List<Part> parts;
  final String role;

  Content({
    required this.parts,
    required this.role,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        parts: List<Part>.from(json["parts"].map((x) => Part.fromJson(x))),
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "parts": List<dynamic>.from(parts.map((x) => x.toJson())),
        "role": role,
      };
}

class Part {
  final String text;

  Part({
    required this.text,
  });

  factory Part.fromJson(Map<String, dynamic> json) => Part(
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
      };
}

class SafetyRating {
  final String category;
  final String probability;

  SafetyRating({
    required this.category,
    required this.probability,
  });

  factory SafetyRating.fromJson(Map<String, dynamic> json) => SafetyRating(
        category: json["category"],
        probability: json["probability"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "probability": probability,
      };
}
