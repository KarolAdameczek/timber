import 'package:flutter/material.dart';

class ProfileCard {
  final int id;
  final String name;
  final String email;
  final String gender;
  final String dragDrop;
  final String loveType;
  final double matchScore;

  ProfileCard({
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.gender,
    @required this.dragDrop,
    @required this.loveType,
    @required this.matchScore,
  });
}