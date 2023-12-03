import 'package:bcode/core/resources/data_state.dart';
import 'package:bcode/core/usecases/usecase.dart';
import 'package:bcode/feature/data/models/note.dart';
import 'package:bcode/feature/domain/entities/note.dart';
import 'package:bcode/feature/domain/repository/note_repository.dart';

class AddNoteUseCase implements UseCase<DataState<NoteEntity>, NoteModel> {
  final NoteRepository _noteRepository;
  AddNoteUseCase(this._noteRepository);

  @override
  Future<DataState<NoteEntity>> call({NoteModel? params}) {
    return _noteRepository.addNote(params!);
  }
}
