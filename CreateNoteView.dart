
import 'package:flutter/material.dart';
import 'package:keepnotes_clone/colors.dart';
import 'package:keepnotes_clone/home.dart';
import 'package:keepnotes_clone/services/db.dart';

import 'model/MyNoteModel.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key});

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
  TextEditingController title = new TextEditingController();
  TextEditingController content = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement initState
    super.initState();
    title.dispose();
    content.dispose();
    super.dispose();
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
                await NotesDatabase.instance.InsertEntry(Note(title: title.text,content: content.text,pin: false,isArchieve :false,createdTime: DateTime.now() ));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (Context)=> Home()));
              },
              icon: Icon(Icons.save_outlined))
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
        child: Column(
          children: [
            TextField(
              controller: title,
              cursorColor: white,
              style: TextStyle(fontSize: 25, color: Colors.white,fontWeight: FontWeight.bold),
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
            Container(
              height: 300,
              child: TextField(
                controller: content,
                style: TextStyle( color: Colors.white),
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
              )),
          ],
        ),
      ),
    );
  }
}
