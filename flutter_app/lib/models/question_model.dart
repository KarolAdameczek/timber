import 'package:flutter/material.dart';

class Question {
  final int id;
  final String type;
  final String question;
  final List<dynamic> options;
  final String code;

  Question({
    @required this.id,
    @required this.type,
    @required this.question,
    @required this.options,
    @required this.code,
  });
}

List<Question> generateQuestions(Map<String, dynamic> map){
  List<Question> list = [];
  int i = 0;
  while(map[i.toString()]!=null){
    list.add(new Question(id: i, type: 'Single', question: map[i.toString()]['text'], options: ['Bardzo','SrednioBardzo','Srednio','SrednioMalo','Malo'],code: map[i.toString()]['id']));
    i++;
  }
  return list;
}