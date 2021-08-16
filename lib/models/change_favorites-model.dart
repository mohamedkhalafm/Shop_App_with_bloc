// ignore: unused_import
import 'dart:convert';

class ChangeFavoritesModel
{
  bool status;
  String message;

  ChangeFavoritesModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
  }
}