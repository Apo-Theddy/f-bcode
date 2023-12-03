import "package:bcode/core/resources/data_state.dart";
import "package:bcode/feature/domain/usecases/add_note.dart";
import "package:bcode/feature/domain/usecases/get_note.dart";
import "package:bcode/feature/presentation/bloc/notes/remote/remote_note_events.dart";
import "package:bcode/feature/presentation/bloc/notes/remote/remote_note_states.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class RemoteNotesBloc extends Bloc<RemoteNotesEvent, RemoteNoteState> {
  final GetNoteUseCase _getNoteUseCase;
  final AddNoteUseCase _addNoteUseCase;

  RemoteNotesBloc(this._getNoteUseCase, this._addNoteUseCase)
      : super(const RemoteNotesLoading()) {
    on<GetNotes>(onGetNotes);
    on<SaveNote>(onSaveNote);
  }
  void onGetNotes(GetNotes event, Emitter<RemoteNoteState> emit) async {
    final dataState = await _getNoteUseCase();

    if (dataState is DataSuccess) {
      emit(RemoteNotesDone(dataState.data!));
    }
    if (dataState is DataFailed) {
      emit(RemoteNotesError(dataState.error!));
    }
  }

  void onSaveNote(SaveNote event, Emitter<RemoteNoteState> emit) async {
    await _addNoteUseCase.call(params: event.note);
    final dataState = await _getNoteUseCase();
    emit(const RemoteNotesLoading());
    emit(RemoteNotesDone(dataState.data!));
  }
}
