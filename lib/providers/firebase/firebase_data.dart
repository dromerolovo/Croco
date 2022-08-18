import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


var db = FirebaseFirestore.instance;

final firebaseDataProvider = StreamProvider.family((ref, String objectIdentifier){
  final docRef = db.collection(objectIdentifier);
  
  return docRef.snapshots();
});