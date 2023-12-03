import "package:bcode/core/constants/constants.dart";
import "package:bcode/feature/data/models/note.dart";
import "package:dio/dio.dart";
import "package:retrofit/retrofit.dart";

part "notes_api_service.g.dart";

@RestApi(baseUrl: notesAPIBaseURL)
abstract class NoteApiService {
  factory NoteApiService(Dio dios) = _NoteApiService;

  @GET("/notes")
  Future<HttpResponse<List<NoteModel>>> getNotes();

  @POST("/notes")
  Future<HttpResponse<NoteModel>> addNote(NoteModel note);
}
