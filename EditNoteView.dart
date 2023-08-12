import 'package:flutter/material.dart';
import 'package:keepnotes_clone/NoteView.dart';
import 'package:keepnotes_clone/colors.dart';
import 'package:keepnotes_clone/home.dart';
import 'package:keepnotes_clone/services/db.dart';

import 'model/MyNoteModel.dart';

class EditNoteView extends StatefulWidget {
  Note note;
  EditNoteView({required this.note});

  @override
  State<EditNoteView> createState() => _EditNoteViewState();
}

class _EditNoteViewState extends State<EditNoteView> {
  late String NewTitle ;
  late String NewNoteDetail ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.NewTitle = widget.note.title.toString();
    this.NewNoteDetail = widget.note.content.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () async {
                Note newNote = Note(content: NewNoteDetail, title: NewTitle,createdTime: widget.note.createdTime,pin: widget.note.pin,isArchieve: widget.note.isArchieve,id: widget.note.id);
                await NotesDatabase.instance.updateNote(newNote);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context)=>Home()));
              },
              icon: Icon(Icons.save_outlined))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Form(
              child: TextFormField(
                initialValue: NewTitle,
                cursorColor: white,
                onChanged: (value){
                  NewTitle = value;
                },
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.withOpacity(0.8),
                    )),
              ),
            ),
            Container(
                height: 300,
                child: Form(
                  child: TextFormField(
                    onChanged: (value){
                      NewNoteDetail = value;
                    },
                    initialValue: NewNoteDetail,
                    style: TextStyle(color: Colors.white),
                    cursorColor: white,
                    keyboardType: TextInputType.multiline,
                    minLines: 50,
                    maxLines: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Note",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(0.8),
                        )),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
