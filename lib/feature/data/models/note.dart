import 'package:bcode/feature/domain/entities/note.dart';

class NoteModel extends NoteEntity {
  NoteModel(
      {String? id,
      String? title,
      String? shortContent,
      int? creationDate,
      Map<String, dynamic>? content,
      List<dynamic>? tags})
      : super(
            id: id,
            title: title,
            shortContent: shortContent,
            creationDate: creationDate,
            content: content,
            tags: tags);

  factory NoteModel.fromJson(Map<String, dynamic> map) {
    return NoteModel(
        id: map["_id"] ?? "",
        title: map["title"] ?? "",
        shortContent: map["short_content"] ?? "",
        creationDate: map["creation_date"] ?? "",
        content: map["content"] ?? "",
        tags: map["tags"] ?? []);
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "short_content": shortContent,
      "content": content,
      "tags": tags
    };
  }
}
