import 'package:flutter/material.dart';
import 'package:keepnotes_clone/colors.dart';
import 'package:keepnotes_clone/services/login_info.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late bool value;
  getSyncSet() async{
    LocalDataSaver.getSyncSet().then((valueFromDB){

        setState(() {
          value = valueFromDB!;
        });

    });
  }

  @override
  void initState() {
    getSyncSet();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        foregroundColor: white,
        title: Text("Settings"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Text("sync",style: TextStyle(color: Colors.white,fontSize: 20),),
                Spacer(),
                Transform.scale(scale: 0.9,
                child: Switch.adaptive(
                    value: value,
                    onChanged: (switchValue) {
                      setState(() {
                        this.value = switchValue;
                        LocalDataSaver.saveSyncSet(switchValue);
                      });
                    }),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
