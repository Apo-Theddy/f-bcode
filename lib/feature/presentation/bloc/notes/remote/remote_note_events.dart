import 'package:bcode/feature/data/models/note.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteNotesEvent extends Equatable {
  final NoteModel? note;
  const RemoteNotesEvent({this.note});

  @override
  List<Object> get props => [note!];
}

class GetNotes extends RemoteNotesEvent {
  const GetNotes();
}

class SaveNote extends RemoteNotesEvent {
  const SaveNote(NoteModel note) : super(note: note);
}
