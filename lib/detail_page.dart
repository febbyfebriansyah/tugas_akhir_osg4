import 'package:flutter/material.dart';
import 'package:tugas_akhir_osg4/deck.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Deck card = ModalRoute.of(context).settings.arguments;
    
    Widget descriptionSection = Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              'Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            )
          ),
          Text(
            card.desc,
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text('Card Detail'),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.82,
            child: FadeInImage(
              placeholder: AssetImage('assets/images/waiting.png'),
              image: NetworkImage(card.card_images[0].values.toList()[1]),
            ),
          ),
          descriptionSection
        ],
      ),
    );
  }
}
