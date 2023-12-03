import 'package:bcode/core/resources/data_state.dart';
import 'package:bcode/feature/data/models/note.dart';
import 'package:bcode/feature/domain/entities/note.dart';

abstract class NoteRepository {
  Future<DataState<List<NoteEntity>>> getNotes();
  Future<DataState<NoteEntity>> addNote(NoteModel note);
}
