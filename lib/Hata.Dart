import 'package:flutter/material.dart';
import 'package:avatar_view/avatar_view.dart';

class Hata extends StatefulWidget {
  @override
  _HataState createState() => _HataState();
}

class _HataState extends State<Hata> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HATA !!!'),
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
                  imagePath: "assets/images/avatar_err.png",
                  placeHolder: Container(
                    child: Icon(Icons.person, size: 50,),
                  ),
                  errorWidget: Container(
                    child: Icon(Icons.error, size: 50,),
                  ),
                ),
              ),

              Text(
                  'Kullanıcı adı ya da şifre hatalı!!',
                   style: TextStyle(
                      color : Colors.red,
                      fontSize: 20,
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
