import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently/DM/category_dm.dart';
import 'package:evently/core/constant_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventData{
  EventData({required this.category,required this.tittle,required this.description,required this.date,this.lng,this.lte,this.id ='',required this.uId});
  final String tittle;
  String id;
 final String description;
  final DateTime date;
  String uId;
 final double? lng;
 final double? lte;
 final CategoryDM category;



  Map<String,dynamic> toJson()=>{
   "id":id,
    "title":tittle,
    "description":description,
    "date":Timestamp.fromDate(date),
    "categoryId":category.id,
   "uId":uId,
   "lng":lng,
   "lte":lte


  };
 EventData.fromJson(Map<String,dynamic>json):this(
  uId: json['uId'],
   lng: json['lng']?? 0,
   lte: json['lte']?? 0,
   id: json["id"],
   tittle: json["title"],
   description: json["description"],
   date: json['date'].toDate(),
   category: ConstantManager.categories.firstWhere((category) =>category.id==json["categoryId"],
   )


 );}