import 'package:flutter/material.dart';
import 'package:sifre_defteri/Ekle.dart';
import 'package:sifre_defteri/db_Helper.dart';
import 'package:sqflite/sqflite.dart';

class RecordList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return RecordListState();
  }
}

class RecordListState extends State<RecordList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Record> recordList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (recordList == null) {
      recordList = [];
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('KAYITLAR'),
      ),
      body: getRecordListView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //debugPrint('FAB clicked');
          navigateToDetail(Record('', ''), 'Kayıt Ekle');
        },
        tooltip: 'Kayıt Ekle',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getRecordListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.amberAccent,
              child: Text(getFirstLetter(this.recordList[position].name.toUpperCase()),
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            title: Text(this.recordList[position].name,
                style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(this.recordList[position].pass),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(Icons.delete,color: Colors.red,),
                  onTap: () {
                    _delete(context, recordList[position]);
                  },
                ),
              ],
            ),
            onTap: () {
              //debugPrint("ListTile Tapped");
              navigateToDetail(this.recordList[position], 'Kayıt Düzenle');
            },
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(BuildContext context, Record record) async {
    int result = await databaseHelper.deleteRecord(record.id);
    if (result != 0) {
      _showSnackBar(context, 'Kayıt silindi');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    //Scaffold.of(context).showSnackBar(snackBar);
    ScaffoldMessenger.of(context).showSnackBar(
        snackBar
        );
  }

  void navigateToDetail(Record record, String name) async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return RecordDetail(record, name);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Record>> recordListFuture = databaseHelper.getRecordList();
      recordListFuture.then((recordList) {
        setState(() {
          this.recordList = recordList;
          this.count = recordList.length;
        });
      });
    });
  }


}