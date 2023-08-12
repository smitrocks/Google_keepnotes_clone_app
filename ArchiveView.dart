import 'package:flutter/material.dart';
import 'package:keepnotes_clone/SearchPage.dart';
import 'package:keepnotes_clone/services/db.dart';
import 'package:keepnotes_clone/services/login_info.dart';
import 'CreateNoteView.dart';
import 'package:keepnotes_clone/NoteView.dart';
import 'package:keepnotes_clone/SideMEnuBar.dart';
import 'package:keepnotes_clone/colors.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'model/MyNoteModel.dart';

class ArchiveView extends StatefulWidget {
  @override
  State<ArchiveView> createState() => _ArchiveViewState();
}

class _ArchiveViewState extends State<ArchiveView> {
  bool isLoading = true;
  late List<Note> notesList =[];
  Future getAllNotes() async {

    this.notesList = await NotesDatabase.instance.readAllArchiveNotes();
    if (this.mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  String note =
      "THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE THIS IS NOTE ";
  String note1 = "THIS IS NOTE THIS IS NOTE THIS IS NOTE";

  @override
  void initState() {
    // createEntry(Note(
    //     pin: false,
    //     title: "Smit Rana",
    //     content: "This Is Smit",
    //     createdTime: DateTime.now()));
    //deleteNote(notesList[]);
    getAllNotes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
      backgroundColor: bgColor,
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      ),
    )
        : Scaffold(
            floatingActionButton: FloatingActionButton(
              child: Icon(
                Icons.add,
                size: 40,
              ),
              backgroundColor: cardColor,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (Context) => CreateNoteView()));
              },
            ),
            endDrawerEnableOpenDragGesture: true,
            key: _drawerKey,
            drawer: SideMenu(),
            backgroundColor: bgColor,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: black.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 3)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_sharp,
                                    color: white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (Context) =>
                                                SearchView()));
                                  },
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (Context) =>
                                                  SearchView()));
                                    },
                                    child: Container(
                                      height: 55,
                                      width: MediaQuery.of(context).size.width/2,
                                      child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Search Your Notes",
                                              style: TextStyle(
                                                  color: white.withOpacity(0.5),
                                                  fontSize: 16),
                                            )
                                          ]),
                                    ),
                                  )
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                children: [

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      noteSectionAll(),



                    ],
                  ),
                ),
              ),
            ),
          );
  }

  Widget noteSectionAll() {
    return Container(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "ALL",
                  style: TextStyle(
                      color: white.withOpacity(0.5),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: StaggeredGridView.countBuilder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: notesList.length,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              crossAxisCount: 4,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (Context) => NoteView(note: notesList[index])));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(color: white.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notesList[index].title,
                        style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        notesList[index].content.length > 250
                            ? "${note.substring(0, 250)}..."
                            : notesList[index].content,
                        style: TextStyle(color: white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget noteListSectionAll() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Container(
  //           margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
  //           child: Row(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Text(
  //                 "LIST VIEW",
  //                 style: TextStyle(
  //                     color: white.withOpacity(0.5),
  //                     fontSize: 13,
  //                     fontWeight: FontWeight.bold),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Container(
  //           padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
  //           child: ListView.builder(
  //             physics: NeverScrollableScrollPhysics(),
  //             shrinkWrap: true,
  //             itemCount: 8,
  //             itemBuilder: (context, index) => Container(
  //               padding: EdgeInsets.all(10),
  //               margin: EdgeInsets.only(bottom: 10),
  //               decoration: BoxDecoration(
  //                   border: Border.all(color: white.withOpacity(0.4)),
  //                   borderRadius: BorderRadius.circular(10)),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     "HEADING",
  //                     style: TextStyle(
  //                         color: white,
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                   SizedBox(
  //                     height: 10,
  //                   ),
  //                   Text(
  //                     index.isEven
  //                         ? note.length > 250
  //                             ? "${note.substring(0, 250)}..."
  //                             : note
  //                         : note1,
  //                     style: TextStyle(color: white),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
