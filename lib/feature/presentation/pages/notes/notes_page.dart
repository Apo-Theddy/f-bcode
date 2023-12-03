import 'package:bcode/feature/domain/entities/note.dart';
import 'package:bcode/feature/presentation/bloc/notes/remote/remote_note_bloc.dart';
import 'package:bcode/feature/presentation/bloc/notes/remote/remote_note_states.dart';
import 'package:bcode/feature/presentation/pages/notes/add_note_page.dart';
import 'package:bcode/feature/presentation/widgets/note_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as g;
import 'package:simple_grid/simple_grid.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({Key? key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: size.width * 0.25,
              child: TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: "Buscar...",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                g.Get.to(() => AddNotePage(),
                    transition: g.Transition.cupertino);
              },
              child: Icon(Icons.add, color: Colors.black),
            ),
          ],
        ),
      ),
      body: BlocBuilder<RemoteNotesBloc, RemoteNoteState>(builder: (_, state) {
        if (state is RemoteNotesLoading) {
          return const Center(child: CupertinoActivityIndicator());
        }

        if (state is RemoteNotesError) {
          return const Center(child: Icon(Icons.refresh));
        }

        if (state is RemoteNotesDone) {
          return SpGrid(
            children: [
              SpGridItem(
                child: SizedBox(
                  height: size.height -
                      50, // Ajuste la altura según sus necesidades
                  child: ResponsiveGridList(
                    horizontalGridSpacing: 16,
                    verticalGridSpacing: 16,
                    verticalGridMargin: 10,
                    horizontalGridMargin: 10,
                    minItemWidth: 300,
                    minItemsPerRow: 1,
                    maxItemsPerRow: 6,
                    listViewBuilderOptions: ListViewBuilderOptions(),
                    children: state.notes!
                        .map((note) => NoteCard(note: note))
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      }),
    );
  }
}
