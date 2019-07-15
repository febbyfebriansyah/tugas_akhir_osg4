import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_osg4/deck.dart';
import 'package:tugas_akhir_osg4/detail_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MainPage(),
        '/detail': (context) => DetailPage()
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<List<Deck>> getDeck() async {
    final data =
        await http.get("https://db.ygoprodeck.com/api/v5/cardinfo.php");
    final jsonData = json.decode(data.body);

    List<Deck> decks = [];
    for (var card in jsonData) {
      // Deck deck = Deck();
      Deck deck = Deck(
          id: card["id"],
          name: card["name"],
          type: card["type"],
          desc: card["desc"],
          race: card["race"],
          archetype: card["archetype"],
          card_sets: card["card_sets"],
          card_images: card["card_images"],
          card_prices: card["card_prices"]);

      decks.add(deck);
    }

    return decks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text("Yu-Gi-Oh Cards"),
      ),
      body: Container(
        child: FutureBuilder(
          future: getDeck(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 8.0,
                    margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                    child: Container(
                      decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot
                              .data[index].card_images[0].values
                              .toList()[2]),
                        ),
                        title: Text(
                          snapshot.data[index].name,
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          snapshot.data[index].type,
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/detail',
                              arguments: snapshot.data[index]);
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}


