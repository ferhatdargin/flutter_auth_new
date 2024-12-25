import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/blokpage.dart';
import 'package:flutter_auth/main.dart';

class Profilepage extends StatelessWidget {
  const Profilepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil Sayfasi"),
        backgroundColor: Color.fromARGB(125, 15, 25, 35),
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app),onPressed: (){
            FirebaseAuth.instance
            .signOut()
            .then((result){
              Navigator.pushAndRemoveUntil(context,
               MaterialPageRoute(builder: (_) => HomePage()), 
               (Route<dynamic> route) => false);
            });
          }),
        ],
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
      onPressed: (){
        Navigator.pushAndRemoveUntil(
          context,
               MaterialPageRoute(builder: (_) => Blokpage()), 
               (Route<dynamic> route) => false);
    }),
    
      body: Container(),
    );
  }
}