import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:flutter/material.dart';

final userAuth = StreamProvider<User?>(
  (ref) => FirebaseAuth.instance.authStateChanges(),
);





