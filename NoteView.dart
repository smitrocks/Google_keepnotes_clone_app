import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keepnotes_clone/EditNoteView.dart';
import 'package:keepnotes_clone/colors.dart';
import 'package:keepnotes_clone/home.dart';
import 'package:keepnotes_clone/model/MyNoteModel.dart';
import 'package:keepnotes_clone/services/db.dart';
import 'ArchiveView.dart';


class NoteView extends StatefulWidget {
  Note note;
  NoteView({required this.note});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        foregroundColor: white,
        actions: [
          IconButton(
            splashRadius: 17,
            onPressed: () async {
              await NotesDatabase.instance.pinNote(widget.note);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
            icon: Icon(
                widget.note.pin ? Icons.push_pin : Icons.push_pin_outlined),
            color: white,
          ),
          IconButton(
            splashRadius: 17,
            onPressed: () async {
              await NotesDatabase.instance.archNote(widget.note);
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ArchiveView()));
            },
            icon: Icon(widget.note.isArchieve
                ? Icons.archive
                : Icons.archive_outlined),
            color: white,
          ),
          IconButton(
            splashRadius: 17,
            onPressed: () async {
              await NotesDatabase.instance.deleteNote(widget.note);
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (Context) => Home()));
            },
            icon: Icon(Icons.delete_forever_outlined),
            color: white,
          ),
          IconButton(
            splashRadius: 17,
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (Context) => EditNoteView(note: widget.note)));
            },
            icon: Icon(Icons.edit_outlined),
            color: white,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Created On ${DateFormat('dd-MM-yyyy - kk:mm').format(widget.note.createdTime)}",style: TextStyle(color: Colors.white),),
              SizedBox(height: 10,),
              Text(
                widget.note.title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(widget.note.content, style: TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
