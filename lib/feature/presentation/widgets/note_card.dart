import 'package:bcode/feature/data/models/note.dart';
import 'package:bcode/feature/domain/entities/note.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:bcode/feature/presentation/pages/notes/info_note_page.dart';
import "package:intl/intl.dart";

class NoteCard extends StatelessWidget {
  final NoteEntity? note;
  const NoteCard({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(note!.creationDate!);
    String formattedDate = DateFormat('dd MMMM y', 'es').format(dateTime);

    List<Color> coloresEtiquetas = [
      Color(0xFFE0F7FA),
      Color(0xFFFFF9C4),
      Color(0xFFE8F5E9),
      Color(0xFFFFEBEE),
    ];

    return GestureDetector(
      onTap: () {
        Get.to(() => InfoNotePage(note: note),
            transition: Transition.cupertino);
      },
      child: Neumorphic(
        margin: EdgeInsets.all(16.0),
        style: NeumorphicStyle(
          depth: 5.0,
          intensity: 0.6,
          shape: NeumorphicShape.convex,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12.0)),
          color: Colors.white, // Nuevo color de fondo
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFFE0F7FA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
              ),
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              child: Text(
                formattedDate,
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF455A64),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    note!.title!,
                    style: GoogleFonts.nunito(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF455A64),
                    ),
                  ),
                  SizedBox(height: 12.0),
                  Text(
                    note!.shortContent!,
                    style: GoogleFonts.nunito(
                      color: Color(0xFF78909C),
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (note!.tags!.isNotEmpty)
                    Text(
                      "Etiquetas:",
                      style: GoogleFonts.nunito(
                        fontSize: 18.0,
                        color: Color(0xFF455A64),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(height: 12.0),
                  if (note!.tags!.isNotEmpty)
                    Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: note!.tags!.asMap().entries.map((entry) {
                          int index = entry.key;
                          String etiqueta = entry.value;
                          Color colorEtiqueta = coloresEtiquetas[index];

                          return Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            decoration: BoxDecoration(
                              color: colorEtiqueta,
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                color: colorEtiqueta,
                                width: 2.0,
                              ),
                            ),
                            child: Text(
                              etiqueta,
                              style: GoogleFonts.nunito(
                                fontSize: 14.0,
                                color: Color(0xFF455A64),
                              ),
                            ),
                          );
                        }).toList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
