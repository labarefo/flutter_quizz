import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quizz/question.dart';

class PageQuizz extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    return new _MaPageQuizzState();
  }

}

class _MaPageQuizzState extends State<PageQuizz> {

  List<Question> listeQuestions = [
    new Question('La devise de la Belgique est l\'union fait la force', true, '', 'belgique.jpg'),
    new Question('La lune va finir par tomber sur terre à cause de la gravité', false, 'Au contraire la lune s\'éloigne', 'lune.jpg'),
    //*
    new Question('La Russie est plus grande en superficie que Pluton', true, '', 'russie.jpg'),
    new Question('Nyctalope est une race naine d\'antilope', false, 'C’est une aptitude à voir dans le noir', 'nyctalope.jpg'),
    new Question('Le Commodore 64 est l\’oridnateur de bureau le plus vendu', true, '', 'commodore.jpg'),
    new Question('Le nom du drapeau des pirates es black skull', false, 'Il est appelé Jolly Roger', 'pirate.png'),
    new Question('Haddock est le nom du chien Tintin', false, 'C\'est Milou', 'tintin.jpg'),
    new Question('La barbe des pharaons était fausse', true, 'A l\'époque déjà ils utilisaient des postiches', 'pharaon.jpg'),
    new Question('Au Québec tire toi une bûche veut dire viens viens t\'asseoir', true, 'La bûche, fameuse chaise de bucheron', 'buche.jpg'),
    new Question('Le module lunaire Eagle possédait 4Ko de Ram', true, 'Dire que je me plains avec mes 8GO de ram sur mon mac', 'eagle.jpg'),

     //*/
  ];

  Question quizz;



  String titre = 'Le quizz';

  int index = 0;
  int score = 0;
  int numero = 1;

  @override
  void initState() {
    super.initState();
    quizz = listeQuestions[index];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(titre),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            new Text('Question numéro $numero'),
            new Text('Score $score/$index'),
            new Card(
              elevation: 9.0,
              child: new Container(
                width: MediaQuery.of(context).size.height / 2.5,
                child: new Image.asset('assets/${quizz.imagePath}'),
              ),
            ),
            new Text(quizz.question),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                reponse(quizz, true),
                reponse(quizz, false)
              ],
            ),
          ],
        ),
      ),
    );
  }

  RaisedButton reponse(Question question, bool reponse) {
    return new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        onPressed: () => verifierEtContinuer(question, reponse),
        child: new Text(reponse ? 'Vrai' : 'Faux'),
    );
  }

  void verifierEtContinuer(Question question, bool reponse) {
    if(question.reponse == reponse){
      score++;
      resultat("C'est gagné!", question.explication, true, 'assets/vrai.jpg');
    }else{
      resultat("Oups! perdu...", question.explication, false, 'assets/faux.jpg');
    }
  }

  Future<Null> resultat(String titre, String explication, bool reponse, String imageReponsePath) async {
    return showDialog(context: context,
      barrierDismissible: false,
      builder:(BuildContext context) {
      return new SimpleDialog(
        title: new Text( titre , // reponse ? "C'est gagné!" : "Oups! perdu..."
          textScaleFactor: 1.5,
          style: new TextStyle(color: reponse ? Colors.green : Colors.red),),
        children: [
          new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // image 
              new Card(
                elevation: 9.0,
                child: new Container(
                  width: MediaQuery.of(context).size.height / 2.5,
                  child: new Image.asset(imageReponsePath),
                ),
              ),
             
              // explication
              new Text(explication),
              
              // bouton suivant
              new RaisedButton(
                textColor: Colors.white,
                  color: Colors.blue,
                  child: new Text('Suivant'),
                  onPressed: () {
                    if(index == listeQuestions.length - 1){
                      Navigator.pop(context);
                      terminer();

                    }else{
                      suivant();
                    }
                  })
            ],
          )
        ],
      );
      }
    );
  }

  void suivant() {

    setState(() {
      index++;
      numero++;
      this.quizz = listeQuestions[index];
    });

    Navigator.pop(context);

  }

  Future<Null>  terminer() async {
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return new SimpleDialog(
            title: new Text("C'est fini",
              textScaleFactor: 1.4,
              textAlign: TextAlign.center,
              style: new TextStyle(color: Colors.green, fontStyle: FontStyle.italic),
            ),
            contentPadding: EdgeInsets.all(10.0),
            children: [
              new Text("Votre score est $score/$numero",
                textAlign: TextAlign.center,
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  new Container(
                    height: 1.0,
                  ),
                  new FlatButton(
                      textColor: Colors.blue,
                      child: new Text('OK',
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                      })
                ],
              )
            ],
          );
        }
    );
  }
}
