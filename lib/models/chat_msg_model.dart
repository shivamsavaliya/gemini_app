// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatMsgModel {
  final String role;
  final List<ChartPartModel> parts;

  ChatMsgModel({required this.role, required this.parts});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }

  factory ChatMsgModel.fromMap(Map<String, dynamic> map) {
    return ChatMsgModel(
      role: map['role'] as String,
      parts: List<ChartPartModel>.from(
        (map['parts'] as List<int>).map<ChartPartModel>(
          (x) => ChartPartModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatMsgModel.fromJson(String source) =>
      ChatMsgModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ChartPartModel {
  final String text;

  ChartPartModel({required this.text});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory ChartPartModel.fromMap(Map<String, dynamic> map) {
    return ChartPartModel(
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartPartModel.fromJson(String source) =>
      ChartPartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
