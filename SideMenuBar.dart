
import 'package:flutter/material.dart';
import 'package:keepnotes_clone/ArchiveView.dart';
import 'package:keepnotes_clone/Settings.dart';
import 'package:keepnotes_clone/colors.dart';
import 'package:keepnotes_clone/home.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
            decoration: BoxDecoration(color: bgColor),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: Text(
                      "Google Keep",
                      style: TextStyle(
                          color: white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    color: white.withOpacity(0.2),
                  ),
                  sectionOne(context),
                  SizedBox(height: 5),
                  sectionTwo(context),
                  SizedBox(height: 5),
                  sectionSettings(context),
                ],
              ),
            )));
  }
}

Widget sectionOne(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
        style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all(Colors.orangeAccent.withOpacity(0.3)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50))))),
        onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            children: [
              Icon(
                Icons.lightbulb,
                size: 26,
                color: white.withOpacity(0.7),
              ),
              SizedBox(
                width: 27,
              ),
              Text(
                "Notes",
                style: TextStyle(color: white.withOpacity(0.7), fontSize: 18),
              )
            ],
          ),
        ),
      ));
}




Widget sectionTwo(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50))))),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ArchiveView()));
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            children: [
              Icon(
                Icons.archive_outlined,
                size: 26,
                color: white.withOpacity(0.7),
              ),
              SizedBox(
                width: 27,
              ),
              Text(
                "Archive",
                style: TextStyle(color: white.withOpacity(0.7), fontSize: 18),
              )
            ],
          ),
        ),
      ));
}

Widget sectionSettings(BuildContext context) {
  return Container(
      margin: EdgeInsets.only(right: 10),
      child: TextButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(50),
                    bottomRight: Radius.circular(50))))),
         onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (Context)=> Settings()));
                }, 
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: Row(
            children: [
              Icon(
                Icons.settings_outlined,
                size: 26,
                color: white.withOpacity(0.7),
              ),
              SizedBox(
                width: 27,
              ),
              Text(
                "Settings",
                style: TextStyle(color: white.withOpacity(0.7), fontSize: 18),
              )
            ],
          ),
        ),
      ));
}
