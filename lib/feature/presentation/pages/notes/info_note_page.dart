import "package:bcode/feature/domain/entities/note.dart";
import "package:appflowy_editor/appflowy_editor.dart";
import "package:flutter_neumorphic/flutter_neumorphic.dart";
import "package:textfield_tags/textfield_tags.dart";

class InfoNotePage extends StatefulWidget {
  const InfoNotePage({Key? key, required this.note}) : super(key: key);
  final NoteEntity? note;

  @override
  State<InfoNotePage> createState() => _InfoNotePageState();
}

class _InfoNotePageState extends State<InfoNotePage> {
  final _focusTitle = FocusNode();
  final titleController = TextEditingController(text: "Titulo del documento");
  late EditorState editorState;

  late AppFlowyEditor editor;
  bool isEditTitle = false;
  final _controller = TextfieldTagsController();

  @override
  void initState() {
    editorState =
        EditorState(document: Document.fromJson(widget.note!.content!));
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
                print("guardar");
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
                    initialTags: widget.note!.tags!
                        .map((note) => note.toString())
                        .toList(),
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
