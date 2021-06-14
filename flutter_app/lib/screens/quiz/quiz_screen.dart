import 'package:flutter/material.dart';
import 'package:flutter_app/models/question_model.dart';
import 'package:flutter_app/utilities/constants.dart';
import 'package:flutter_app/utilities/globals.dart';



class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  // Controllers
  List<Question> questions;
  int idx = 0;
  List<String> startingAnswers;
  List<String> answers;
  Question q;

  void _nextQuestion(int questionId, int answerId) async {
    if(questions[questionId].options.toString() == '[Całkowicie się zgadzam, Trochę się zgadzam, Nie mam zdania, Trochę się niezgadzam, Całkowicie się niezgadzam]'){
      answers[questionId] = (answerId+1).toString();
    } else {
      answers[questionId] = answerId.toString();
    }
    idx++;
    if (questions.length > idx) {
      setState(() {
        q = questions[idx];
        if(q.type == 'Sortable'){
          startingAnswers = List<String>.filled(q.options.length, '-');
          for(var i = 0; i < q.options.length; i++){
            startingAnswers[i] = q.options[i];
          }
        }

      });
    } else {
      await api.sendSurveyAnswers(answers);
      Navigator.pushNamed(context, '/home');
    }
  }


  void _saveOrderAndNextQuestion(int questionId) async{
    answers[questionId] = _exportChangedOrder(questions[questionId].options).join(',');
    idx++;
    if (questions.length > idx) {
      setState(() {
        q = questions[idx];
        if(q.type == 'Sortable'){
          startingAnswers = List<String>.filled(q.options.length, '-');
          for(var i = 0; i < q.options.length; i++){
            startingAnswers[i] = q.options[i];
          }
        }
      });
    } else {
      await api.sendSurveyAnswers(answers);
      Navigator.pop(context);
    }
  }


  Widget _selectQuestionType(Question question) {
    if (question.type == 'Single') {
      return _buildBasicQuestion(question);
    } else if(question.type =='Sortable'){

      return _buildSortableQuestion(question);
    } else {
      return null;
    }
  }

  List<String> _exportChangedOrder(List<dynamic> alteredOrder){
    var tmp = List<String>.filled(startingAnswers.length, '-');
    for(var i = 0; i < startingAnswers.length; i++){
      tmp[i] = startingAnswers.indexOf(alteredOrder[i]).toString();
    }
    return tmp;
  }

  //Widget - View

  Widget _buildSortableQuestion(Question question) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: 40.0,
          right: 40.0,
          top: 80.0,
          bottom: 40.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildQuestionText(question),
            SizedBox(height: 20.0),
            Container(
              height: question.options.length * 80.0,
              width: MediaQuery.of(context).size.width,
              child: Theme(
                data: ThemeData(
                  canvasColor: Colors.transparent,
                ),
                child: ReorderableListView(
                  children: <Widget>[
                    for (int index = 0;
                        index < question.options.length;
                        index++)
                      ListTile(
                        key: Key('$index'),
                        title: Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          alignment: Alignment.center,
                          decoration: boxDecorationStyle,
                          height: 60.0,
                          child: Text(
                            question.options[index],
                            style: labelStyle,
                          ),
                        ),
                      ),
                  ],
                  onReorder: (oldIndex, newIndex) {
                    setState(() {
                      if (newIndex > oldIndex) {
                        newIndex -= 1;
                      }
                      final String item = question.options.removeAt(oldIndex);
                      question.options.insert(newIndex, item);
                    });
                  },
                ),
              ),
            ),
            _buildNextQuestionBtn(question),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicQuestion(Question question) {
    return Container(
      height: double.infinity,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.only(
          left: 40.0,
          right: 40.0,
          top: 80.0,
          bottom: 40.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildQuestionText(question),
            _buildQuestionHint(
                'Wybierz jedną z poniższych odpowiedzi.'),
            SizedBox(height: 10.0),
            Container(
              height: question.options.length * 90.0,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: question.options.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _buildQuestionOption(question, index);
                  }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionText(Question question) {
    return Column(children: <Widget>[
      Container(
        padding: EdgeInsets.only(bottom: 10.0),
        alignment: Alignment.center,
        child: Text(
          'Pytanie ${question.id + 1}:',
          style: TextStyle(
            color: textColor,
            fontFamily: 'OpenSans',
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 1.0,
                color: Colors.black26,
                offset: Offset(3.0, 3.0),
              ),
            ],
          ),
        ),
      ),
      Container(
        alignment: Alignment.bottomLeft,
        child: Text(
          question.question,
          style: TextStyle(
            color: textColor,
            fontFamily: 'OpenSans',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 1.0,
                color: Colors.black26,
                offset: Offset(3.0, 3.0),
              ),
            ],
          ),
        ),
      ),
    ]);
  }

  Widget _buildQuestionHint(String hint) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 15.0),
      alignment: Alignment.bottomLeft,
      child: Text(
        hint,
        style: TextStyle(
          color: textColor.withOpacity(0.6),
          fontFamily: 'OpenSans',
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 2.0,
              color: Colors.black26,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionOption(Question question, int oid) {
    return Container(
      padding: EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: () => _nextQuestion(question.id, oid),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          alignment: Alignment.center,
          decoration: boxDecorationStyle,
          height: 60.0,
          child: Text(
            question.options[oid],
            style: labelStyle,
          ),
        ),
      ),
    );
  }

  Widget _buildNextQuestionBtn(Question question) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        backgroundColor: Colors.white,
        onPressed: () => _saveOrderAndNextQuestion(question.id),
        child: Text(
          'NASTĘPNE PYTANIE',
          style: btnStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    questions = ModalRoute.of(context).settings.arguments;
    if(answers == null) {
      answers = List<String>.filled(questions.length, '');
    }
    q = questions[idx];
    return Scaffold(
      body: Stack(
        children: <Widget>[
          background,
          _selectQuestionType(q),
        ],
      ),
    );
  }
}
