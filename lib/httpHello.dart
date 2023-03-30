import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //http kütüphanesini ekledik yani http package ekledik

class HttpHelloView extends StatefulWidget {
  const HttpHelloView({Key? key}) : super(key: key);

  @override
  State<HttpHelloView> createState() => _HttpHelloViewState();
}

class _HttpHelloViewState extends State<HttpHelloView> {
  late bool isHaveData; //bir degisken tanımladık bool bir degisken sayfa acılısında false olacak oyle ayarlamisiz
  String data="";

  @override
  void initState() { //sayfa ilk açıldığında bir kez çalışır, burada sayfa açıldığında yapılacak olan işlemlerimizi yazıyoruz
    // TODO: implement initState
    super.initState();
    isHaveData = false;
  }

  Future getApiJohnName() async{
    //bir fonksiyon oluşturduk johnun ismini getir diye
    var data =  (await http.get(Uri.parse("https://hwasampleapi.firebaseio.com/api/books/0/author.json"))).body;
    //http package ı kullanıyoruz http.get git getir anlamında
    //Uri.parse ise bir url verirken kullandığımız bize yardımcı olan bir sınıf
    //data diye bir final degisken tanimladik icerisine de http package sayesinde o adrese gidiyor
    //bunu yaparken await yazdık başına ki bu http package işini bitirene kadar bekleyelim
    //bu Future bir fonksiyon olduğu için de future demek ilerde anlamındadır. bu fonksiyon asenkron çalışır
    //yani uygulamada diğer işlemler devam ederken bu da aynı anda devam edebilir genellikle hep futurelarla çalışırız.
    //git o adrese o adresin bodysni getir demiş olduk ve bodysini data ya atadık. yani o adreste yazan John Smith yazısı
    //decode etmemiz gerekiyor kullanabileceğimiz hale çeviriyoruz .body den gelen veriyi yani
    data = jsonDecode(data); //decode et ve güncelle datamizi


    setState(() {
      //setState içerisindeki kodları çalışıtırr ve sayfayı yeniler
      this.isHaveData = !isHaveData;
      this.data = data;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isHaveData ? Text(this.data) : CircularProgressIndicator(),
            //eğer isHaveData true ise şunu göster değilse text widgetı göster dedik
            ElevatedButton(
                onPressed: () async{
                  await getApiJohnName(); //fonksiyonumuzu çağırdık
                },
                child: Text("Send Request")),
          ],
        ),
      ),
    );
  }
}


