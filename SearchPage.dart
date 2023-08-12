import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:keepnotes_clone/colors.dart';
import 'package:keepnotes_clone/services/db.dart';
import 'home.dart';
import 'NoteView.dart';
import 'model/MyNoteModel.dart';

class SearchView extends StatefulWidget {


  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  bool isLoading = false;

  List<int> SearchResultIds = [];
  List<Note?> SearchResultNotes = [];
  String note = "THIS IS NOTES";

  void SearchResults(String query) async{
    SearchResultNotes.clear();
    setState(() {
      isLoading =true;
    });
    final ResultsIds = await NotesDatabase.instance.getNoteString(query);
    List<Note?> SearchResultNotesLocal = [];
    ResultsIds.forEach((element) async {
      final SearchNote =await NotesDatabase.instance.readOneNote(element);
      SearchResultNotesLocal.add(SearchNote);
      setState(() {
        SearchResultNotes.add(SearchNote);
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: white.withOpacity(0.09),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(onPressed: () {
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back),color: white,),
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.search,
                        style: TextStyle(
                          color: white,
                        ),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Search Your Notes",
                            hintStyle: TextStyle(color: white.withOpacity(0.5), fontSize: 16)),
                        onSubmitted: (value){
                          setState(() {
                            SearchResults(value.toLowerCase());
                          });
                        },
                      ),
                    ),

                  ],
                ),
                isLoading ? Center(child: CircularProgressIndicator(color: Colors.white,),) :  noteSectionAll()
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
                  "SEARCH RESULTS",
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
              itemCount: SearchResultNotes.length,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              crossAxisCount: 4,
              staggeredTileBuilder: (index) => StaggeredTile.fit(2),
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (Context) => NoteView(note: SearchResultNotes[index]!)));
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
                        SearchResultNotes[index]!.title,
                        style: TextStyle(
                            color: white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        SearchResultNotes[index]!.content.length > 250
                            ? "${note.substring(0, 250)}..."
                            : SearchResultNotes[index]!.content,
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
}
