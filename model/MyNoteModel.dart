import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String customDate = "26 Jan 2018";
DateTime dateTime = DateFormat("dd MMM yyyy").parse(customDate);
String iso8601String = dateTime.toIso8601String();

class NotesImpNames {
  static final String id = "id";
  static final String pin = "pin";
  static final String title = "title";
  static final String content = "content";
  static final String createdTime = "createdTime";
  static final String TableName = "Notes";
  static final String isArchieve = "isArchive";

  static final List<String> values = [id,isArchieve, pin, title, content, createdTime];
}

class Note {
  final int? id;
  final bool pin;
  final bool isArchieve;
  final String title;
  final String content;
  final DateTime createdTime;

  const Note(
      {this.id,
      required this.pin,
      required this.isArchieve,
      required this.title,
      required this.content,
      required this.createdTime});

  Note copy({
    int? id,
    bool? pin,
    bool? isArchieve,
    String? title,
    String? content,
    DateTime? createdTime,
  }) {
    return Note(
        id: id ?? this.id,
        pin: pin ?? this.pin,
        isArchieve: isArchieve ?? this.isArchieve,
        title: title ?? this.title,
        content: content ?? this.content,
        createdTime: createdTime ?? this.createdTime);
  }

  static Note fromJson(Map<String, Object?> json) {
    DateTime parsedDate;
    try {
      parsedDate = DateFormat("dd MMM yyyy").parse(json[NotesImpNames.createdTime] as String);
    } catch (e) {
      // Handle the exception here, or set a default value for parsedDate
      print("Error parsing date: $e");
      // Setting a default date, for example, DateTime.now():
      parsedDate = DateTime.now();
    }
    return Note(
      id: json[NotesImpNames.id] as int?,
      pin: json[NotesImpNames.pin] == 1,
      isArchieve: json[NotesImpNames.isArchieve] == 1,
      title: json[NotesImpNames.title] as String,
      content: json[NotesImpNames.content] as String,
      createdTime: parsedDate,
    );
  }

  Map<String, Object?> toJson() {
    return {
      NotesImpNames.id: id,
      NotesImpNames.pin: pin ? 1 : 0,
      NotesImpNames.isArchieve: isArchieve ? 1 : 0,
      NotesImpNames.title: title,
      NotesImpNames.content: content,
      NotesImpNames.createdTime: createdTime.toIso8601String()
    };
  }
}
