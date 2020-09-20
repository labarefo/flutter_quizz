import 'package:flutter/material.dart';
import 'package:flutter_quizz/page_quizz.dart';
import 'package:flutter_quizz/question.dart';


class Body extends StatefulWidget {

  @override
  State createState() => new _BodyState();
}

class _BodyState extends State<Body> {
  String quizzImagePath = 'assets/quizz.jpg';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          new Card(
            elevation: 10.0,
            child: new Container(
              width: MediaQuery.of(context).size.height / 2.5,
              child: new Image.asset(quizzImagePath),
            ),
          ),
          new RaisedButton(
            onPressed: commencerQuizz,
            child: new Text(
              "Commencer les quizz",
              style: new TextStyle(fontStyle: FontStyle.italic, fontSize: 20.0),
            ),
            color: Colors.blue,
            textColor: Colors.white,
          ),
        ],
      )
    );
  }


  void commencerQuizz() {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
      return new PageQuizz();
    }));
  }


}