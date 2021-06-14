import 'package:flutter_app/utilities/api_requests.dart';



ApiRequests api = new ApiRequests();
final RegExp nameRegEx = RegExp(r'^[A-ZŻŹĆĄŚĘŁÓŃ][a-zżźćąśęłóń]+$');
final RegExp emailRegEx = RegExp(r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
final RegExp passwordRegEx = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$');