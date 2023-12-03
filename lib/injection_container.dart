import "package:bcode/feature/data/data_sources/remote/notes_api_service.dart";
import "package:bcode/feature/data/repository/note_repository_impl.dart";
import "package:bcode/feature/domain/repository/note_repository.dart";
import "package:bcode/feature/domain/usecases/add_note.dart";
import "package:bcode/feature/domain/usecases/get_note.dart";
import "package:bcode/feature/presentation/bloc/notes/remote/remote_note_bloc.dart";
import "package:dio/dio.dart";
import "package:get_it/get_it.dart";

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NoteApiService>(NoteApiService(sl()));
  sl.registerSingleton<NoteRepository>(NoteRepositoryImpl(sl()));

  // UseCases
  sl.registerSingleton<GetNoteUseCase>(GetNoteUseCase(sl()));
  sl.registerSingleton<AddNoteUseCase>(AddNoteUseCase(sl()));

  // Blocs
  sl.registerFactory<RemoteNotesBloc>(() => RemoteNotesBloc(sl(), sl()));
}
