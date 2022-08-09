import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croco/providers/firebase/firebase_data.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/firebase/utils.dart';
import 'dart:convert';


class CrocoDataTable extends ConsumerStatefulWidget {
  CrocoDataTable.fromFirestore({
    Key? key,
    required this.objectIdentifier
    }) : super(key: key);

    final String objectIdentifier;

  @override
  ConsumerState<CrocoDataTable> createState() => _CrocoDataTableState();
}

class _CrocoDataTableState extends ConsumerState<CrocoDataTable> {
  @override
  Widget build(BuildContext context) { 
       
    return Container(
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection(widget.objectIdentifier).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator()
            );
          } else {
            Map<String, dynamic> data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
            print(data.keys);

            return Container(
              width: 50, 
              height: 50,
              color: Colors.orange
            );
          }
        }
      )
    );
  }
}