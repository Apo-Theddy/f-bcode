import 'package:equatable/equatable.dart';

class NoteEntity extends Equatable {
  String? id;
  String? title;
  String? shortContent;
  int? creationDate;
  Map<String, dynamic>? content;
  List<dynamic>? tags;

  NoteEntity(
      {this.id,
      this.title,
      this.shortContent,
      this.creationDate,
      this.content,
      this.tags});

  @override
  List<Object?> get props =>
      [id, title, shortContent, creationDate, content, tags];
}
