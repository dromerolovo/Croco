import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final recordsCounterProvider = FutureProvider.family((ref, String objectIndetifier){
  var db = FirebaseFirestore.instance;

  final docRef = db.collection("counter").doc("${objectIndetifier}Counter").snapshots().first;

  return docRef;

});