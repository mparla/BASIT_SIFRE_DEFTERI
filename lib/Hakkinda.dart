import 'package:flutter/material.dart';
import 'package:avatar_view/avatar_view.dart';

class Hakkinda extends StatefulWidget {
  @override
  _HakkindaState createState() => _HakkindaState();
}
class _HakkindaState extends State<Hakkinda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ŞİFRE DEFTERİ HAKKINDA'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 70,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: AvatarView(
                  radius: 60,
                  borderWidth: 8,
                  isOnlyText: false,
                  borderColor:  const Color(0xFF42A5F5),
                  text: Text('C', style: TextStyle(color: Colors.white, fontSize: 50),),
                  avatarType: AvatarType.CIRCLE,
                  backgroundColor: Colors.red,
                  imagePath: "assets/images/avatar.png",
                  //"https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg?cs=srgb&dl=pexels-pixabay-415829.jpg",
                  placeHolder: Container(
                    child: Icon(Icons.person, size: 50,),
                  ),
                  errorWidget: Container(
                    child: Icon(Icons.error, size: 50,),
                  ),
                ),
              ),

              //Text('Bu uygulama Mustafa PARLA tarafından yapılmıştır. '),
              Text( 'Bu uygulama Dr. Öğretim Üyesi Ahmet Cevahir ÇINAR tarafından yürütülen 3301456 kodlu MOBİL PROGRAMLAMA dersi kapsamında 203301106 numaralı Mustafa PARLA tarafından 30 Nisan 2021 günü yapılmıştır.'),
            ],
          ),
        ),
      ),
    );
  }
}