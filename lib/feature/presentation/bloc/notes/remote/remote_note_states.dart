import "package:bcode/feature/domain/entities/note.dart";
import "package:dio/dio.dart";
import "package:equatable/equatable.dart";

abstract class RemoteNoteState extends Equatable {
  final List<NoteEntity>? notes;
  final DioException? error;
  const RemoteNoteState({this.notes, this.error});

  @override
  List<Object> get props => [notes!, error!];
}

class RemoteNotesLoading extends RemoteNoteState {
  const RemoteNotesLoading();
}

class RemoteNotesDone extends RemoteNoteState {
  const RemoteNotesDone(List<NoteEntity> notes) : super(notes: notes);
}

class RemoteNotesError extends RemoteNoteState {
  const RemoteNotesError(DioException error) : super(error: error);
}
