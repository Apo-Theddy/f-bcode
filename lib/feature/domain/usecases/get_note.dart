import 'package:bcode/core/resources/data_state.dart';
import 'package:bcode/core/usecases/usecase.dart';
import 'package:bcode/feature/domain/entities/note.dart';
import 'package:bcode/feature/domain/repository/note_repository.dart';

class GetNoteUseCase implements UseCase<DataState<List<NoteEntity>>, void> {
  final NoteRepository _noteRepository;

  GetNoteUseCase(this._noteRepository);
  @override
  Future<DataState<List<NoteEntity>>> call({void params}) {
    return _noteRepository.getNotes();
  }
}
