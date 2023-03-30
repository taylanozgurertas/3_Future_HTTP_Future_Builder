import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HttpDeneme2 extends StatefulWidget {
  const HttpDeneme2({Key? key}) : super(key: key);

  @override
  State<HttpDeneme2> createState() => _HttpDeneme2State();
}

class _HttpDeneme2State extends State<HttpDeneme2> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future getApiJohnName() async{

    return (await http.get(Uri.parse("https://hwasampleapi.firebaseio.com/api/books/0/author.json"))).body;
    //future fonksiyonumuz

  }


  @override
  Widget build(BuildContext context) {
    /* var columncenter = Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isHaveData ? Text(this.data) : CircularProgressIndicator(),

            ElevatedButton(
                onPressed: () async{
                  await getApiJohnName();
                },
                child: Text("Send Request")),
          ],
        ); */
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          //2 önemli şey ister FutureBuilder
          future: getApiJohnName(), //future fonksiyonu bekler
          builder: (context, snapshot){ //bu sayfanın contexti ve snapshot verir bize yani snapshot.data da bizim future olarak verdiğimiz fonksiyonun döndürdüğü şey vardır
            if(snapshot.connectionState == ConnectionState.done){ //eğer bağlantı tamamsa
              if(snapshot.hasData) return Text(json.decode(snapshot.data)); //eğer snapshota veri geldiyse
              else Text("you have an error."); //veri gelmediyse
            }else if(snapshot.connectionState == ConnectionState.waiting){ //eğer snasphota bağlantı waiting durumundaysa
              return CircularProgressIndicator();
            }else{ //hiçbir şey olmadıysa
              return Text("you have an error.");
            }
            return Text("huha");
          },
        ),
      ),
    );
  }
}


