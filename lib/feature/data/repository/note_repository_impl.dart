import 'dart:io';

import 'package:bcode/core/resources/data_state.dart';
import 'package:bcode/feature/data/data_sources/remote/notes_api_service.dart';
import 'package:bcode/feature/data/models/note.dart';
import 'package:bcode/feature/domain/entities/note.dart';
import 'package:bcode/feature/domain/repository/note_repository.dart';
import 'package:dio/dio.dart';

class NoteRepositoryImpl implements NoteRepository {
  final NoteApiService _noteApiService;
  NoteRepositoryImpl(this._noteApiService);

  @override
  Future<DataState<List<NoteModel>>> getNotes() async {
    try {
      final httpResponse = await _noteApiService.getNotes();
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<NoteEntity>> addNote(NoteModel note) async {
    try {
      final httpResponse = await _noteApiService.addNote(note);
      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }
}
