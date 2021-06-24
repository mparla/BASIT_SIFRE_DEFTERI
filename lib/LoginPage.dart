import 'package:flutter/material.dart';
import 'package:sifre_defteri/Hakkinda.dart';
import 'package:sifre_defteri/Hata.dart';
import 'package:sifre_defteri/LISTELE.dart';


class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class LoginPage extends StatefulWidget {
  //LoginPage({Key key, this.title}) : super(key: key);


  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  //final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

final unameController = TextEditingController();
final passController = TextEditingController();

String uname = "user";
String pass =  "1234";

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
      title:Center( child:  Text('ŞİFRE DEFTERİ GİRİŞ')) ,
      ),
      body: Center(
        child: Container(

          height: 400,
          width: 300,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("Oturum Aç"),
            TextField(
              controller: unameController,

              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mobile_friendly,),
                hintText: "Kullanıcı adı",
              ),
            ),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.keyboard,),
                hintText: "Şifre",
              ),
            ),
            Padding(padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              child: Text("GİRİŞ"),
              onPressed: () {
                if (uname == unameController.text && pass == passController.text) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (BuildContext context) =>RecordList()));//  MyHomePage(title :'ŞİFRE DEFTERİ')));
                }
                else
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Hata()));
                  }
              },
            ),
          ),
          ],
        ),
      ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> Hakkinda()));
        },
        tooltip: 'Hakkında',
        child: Icon(Icons.contact_support),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}