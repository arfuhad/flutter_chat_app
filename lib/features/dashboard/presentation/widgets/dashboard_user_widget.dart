import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/core.dart';
import 'package:go_router/go_router.dart';

class DashboardUserWidget extends StatelessWidget {
  DashboardUserWidget({super.key}) {
    userCollection = injector<FirebaseDbService>().getUsersCollection;
  }

  late final CollectionReference? userCollection;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: userCollection!
                .orderBy('is_active', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              }

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final messages = snapshot.data!.docs;
              log("dashboard view: $messages");
              log("dashboard view: ${snapshot.data!.docs.length}");
              return ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  log("dashboard view: $message");
                  return Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.indigo.shade200,
                          borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: ListTile(
                        onTap: () {
                          context.push('/chat');
                        },
                        title: Text(
                          message['email'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          message['is_active'] ? "active" : "inactive",
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
