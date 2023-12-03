import 'package:bcode/feature/presentation/bloc/notes/remote/remote_note_bloc.dart';
import 'package:bcode/feature/presentation/bloc/notes/remote/remote_note_events.dart';
import 'package:bcode/feature/presentation/pages/main/main_page.dart';
import 'package:bcode/feature/presentation/pages/notes/add_note_page.dart';
import 'package:bcode/feature/presentation/pages/notes/notes_page.dart';
import 'package:bcode/injection_container.dart';
import 'package:flutter/material.dart';
import "package:appflowy_editor/appflowy_editor.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';
import "package:get/get.dart";

void main() async {
  await initializeDependencies();
  await initializeDateFormatting('es', null);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteNotesBloc>(
      create: (context) => sl()..add(const GetNotes()),
      child: const GetMaterialApp(
          enableLog: false,
          localizationsDelegates: [
            AppFlowyEditorLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          home: MainPage()),
    );
  }
}
