import 'package:flutter/material.dart';
import 'package:sifre_defteri/db_Helper.dart';

class RecordDetail extends StatefulWidget {

  final String appBarTitle;
  final Record record;

  RecordDetail(this.record, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return RecordDetailState(this.record, this.appBarTitle);
  }
}

class RecordDetailState extends State<RecordDetail> {

  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Record record;

  TextEditingController nameController = TextEditingController();
  TextEditingController passController = TextEditingController();

  RecordDetailState(this.record, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    TextStyle textStyle = Theme.of(context).textTheme.title;

    nameController.text = record.name;
    passController.text = record.pass;

    return WillPopScope(

        onWillPop: () {
          moveToLastScreen();
        },

        child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                }
            ),
          ),

          body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: nameController,
                    style: textStyle,
                    onChanged: (value) {
                      //debugPrint('Something changed in Title Text Field');
                      updateTitle();
                    },
                    decoration: InputDecoration(
                        labelText: 'Kayıt Adı',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextField(
                    controller: passController,
                    style: textStyle,
                    onChanged: (value) {
                      //debugPrint('Something changed in Description Text Field');
                      updateDescription();
                    },
                    decoration: InputDecoration(
                        labelText: 'Şifre',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Kaydet',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              //debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),

                      Container(width: 5.0,),

                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Sil',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              //debugPrint("Delete button clicked");
                              _delete();
                            });
                          },
                        ),
                      ),

                    ],
                  ),
                ),


              ],
            ),
          ),

        ));
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Update the title of todo object
  void updateTitle(){
    record.name = nameController.text;
  }

  // Update the description of todo object
  void updateDescription() {
    record.pass = passController.text;
  }

  // Save data to database
  void _save() async {

    moveToLastScreen();

   // record.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    if (record.id != null) {  // Case 1: Update operation
      result = await helper.updateRecord(record);
    } else { // Case 2: Insert Operation
      result = await helper.insertRecord(record);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Durum', 'Kayıt yapıldı');
    } else {  // Failure
      _showAlertDialog('Durum', 'Kayıt yapılamadı!!!');
    }

  }


  void _delete() async {

    moveToLastScreen();

    if (record.id == null) {
      _showAlertDialog('Durum', 'Silinecek kayıt yok');
      return;
    }

    int result = await helper.deleteRecord(record.id);
    if (result != 0) {
      _showAlertDialog('Durum', 'Kayıt silindi..');
    } else {
      _showAlertDialog('Durum', 'Kayıt silinirken bir hata oluştu!');
    }
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}