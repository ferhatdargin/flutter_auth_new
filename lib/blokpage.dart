import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';



class Blokpage extends StatefulWidget {
  const Blokpage({super.key});

  @override
  State<Blokpage> createState() => _HomePageState();
}

class _HomePageState extends State<Blokpage> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController docId = TextEditingController();

  var responseTitle = "";
  var responseContent = "";

  getArticle() {
    FirebaseFirestore.instance
        .collection("articles")
        .doc(docId.text)
        .get()
        .then((response) {
      if (response.data() != null) {
        setState(() {
          responseTitle = response.data()?['title'] ?? "";
          responseContent = response.data()?['content'] ?? "";
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Dokuman bulunamadi")));
      }
    });
  }

  addActicle() {
    FirebaseFirestore.instance
        .collection("articles")
        .doc(title.text)
        .set(<String, dynamic>{
      'title': title.text,
      'title': content.text
    }).whenComplete(() {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Dokuman başarıyla eklendi ")));
    });
  }

  updateActicle() {
    FirebaseFirestore.instance
        .collection("articles")
        .doc(title.text)
        .set(<String, dynamic>{
      'title': title.text,
      'title': content.text
    }).whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Makale Başarıli bir Şekilde güncellendi")));
    });
  }

  deleteActicle() {
    FirebaseFirestore.instance
        .collection("articles")
        .doc(docId.text)
        .delete()
        .whenComplete(() {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Makale Başarıli bir Şekilde Silindi")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar:AppBar(
      title: Text("Blog sayfası "),
    ),
      body: Container(
        margin: EdgeInsets.all(50),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: docId,
                decoration: InputDecoration(labelText: "Döküman Adı "),
              ),
              TextField(
                controller: title,
                decoration: InputDecoration(labelText: "Başlık"),
              ),
              TextField(
                controller: content,
                decoration: InputDecoration(labelText: "İçerik"),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: addActicle, child: Text("EKLE")),
                  ElevatedButton(
                      onPressed: updateActicle, child: Text("GÜNCELLE")),
                  ElevatedButton(onPressed: deleteActicle, child: Text("Sil")),
                  ElevatedButton(onPressed: getArticle, child: Text("GETİR")),
                ],
              ),
              ListTile(
                title: Text(responseTitle),
                subtitle: Text(responseContent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
