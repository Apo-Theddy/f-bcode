import "package:bcode/feature/data/models/note.dart";
import "package:bcode/feature/domain/entities/note.dart";
import "package:bcode/feature/presentation/bloc/notes/remote/remote_note_bloc.dart";
import "package:bcode/feature/presentation/bloc/notes/remote/remote_note_events.dart";
import 'package:flutter/material.dart';
import "package:appflowy_editor/appflowy_editor.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_neumorphic/flutter_neumorphic.dart";
import "package:get/get.dart";
import "package:textfield_tags/textfield_tags.dart";
import "package:animated_snack_bar/animated_snack_bar.dart";

class AddNotePage extends StatefulWidget {
  const AddNotePage({Key? key}) : super(key: key);

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final _focusTitle = FocusNode();
  final titleController = TextEditingController(text: "Titulo del documento");
  final editorState = EditorState.blank(withInitialText: true);
  late AppFlowyEditor editor;
  bool isEditTitle = false;
  final _controller = TextfieldTagsController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _focusTitle.dispose();
    titleController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () async {
                if (!editorState.document.isEmpty) {
                  String editorContent = editorState
                      .document.first!.attributes["delta"][0]["insert"];
                  String shortContent = editorContent.split(" ").length > 20
                      ? editorContent
                          .split(" ")
                          .getRange(0, 20)
                          .map((word) => word.toString())
                          .join(" ")
                      : editorContent;
                  NoteModel note = NoteModel(
                      title: titleController.text.trim(),
                      shortContent: shortContent,
                      content: editorState.document.toJson(),
                      tags: _controller.getTags);
                  Get.back();
                  BlocProvider.of<RemoteNotesBloc>(context).add(SaveNote(note));
                } else {
                  AnimatedSnackBar.material(
                    'No puede guardar un apunte vacio',
                    duration: const Duration(milliseconds: 2000),
                    mobileSnackBarPosition: MobileSnackBarPosition.bottom,
                    animationCurve: Curves.fastOutSlowIn,
                    desktopSnackBarPosition:
                        DesktopSnackBarPosition.bottomCenter,
                    type: AnimatedSnackBarType.warning,
                  ).show(context);
                }
              },
              child: Icon(Icons.save),
            ),
          ),
        ],
        title: InkWell(
          onTap: () {
            setState(() {
              isEditTitle = true;
            });
          },
          child: isEditTitle
              ? TextField(
                  controller: titleController,
                  focusNode: _focusTitle,
                  style: const TextStyle(
                      fontSize: 19, fontWeight: FontWeight.bold),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: InputBorder.none,
                  ),
                )
              : Text(
                  titleController.text,
                  style: const TextStyle(color: Colors.black),
                ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40),
                child: Neumorphic(
                  style: NeumorphicStyle(
                    depth: 5.0,
                    intensity: 0.6,
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(12.0)),
                  ),
                  child: Container(
                      color: Colors.white,
                      height: size.height * 0.8,
                      width: size.width * 0.8,
                      padding: const EdgeInsets.all(10),
                      child: AppFlowyEditor(editorState: editorState)),
                ),
              ),
              SizedBox(height: 10),
              Text("Tags",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
              SizedBox(
                width: size.width / 1.7,
                child: TextFieldTags(
                    textfieldTagsController: _controller,
                    initialTags: const [],
                    inputfieldBuilder:
                        (context, tec, fn, err, onChanged, onSubmitted) {
                      return ((context, sc, tags, onTagDelete) {
                        return Card(
                          color: Colors.white,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: TextField(
                                controller: tec,
                                focusNode: fn,
                                textAlignVertical: TextAlignVertical.center,
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText:
                                      _controller.hasTags ? '' : "Enter tag...",
                                  errorText: err,
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  prefixIcon: tags.isNotEmpty
                                      ? SingleChildScrollView(
                                          controller: sc,
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: tags.map((String tag) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: Colors.red,
                                                ),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 5.0,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 10.0,
                                                  vertical: 10.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      child: Text(
                                                        '#$tag',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      onTap: () {
                                                        print("$tag selected");
                                                      },
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    InkWell(
                                                      child: const Icon(
                                                        Icons.cancel,
                                                        size: 14.0,
                                                        color: Colors.white,
                                                      ),
                                                      onTap: () {
                                                        onTagDelete(tag);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        )
                                      : null,
                                ),
                                onChanged: onChanged,
                                onSubmitted: onSubmitted),
                          ),
                        );
                      });
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
