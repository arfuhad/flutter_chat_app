import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_app/features/auth/auth.dart';

class FirebaseDbService {
  late final FirebaseFirestore _db;

  CollectionReference? _userCollection;
  CollectionReference? _messageCollection;

  FirebaseDbService() {
    _db = FirebaseFirestore.instance;
    _setupCollectionReferences();
  }

  _setupCollectionReferences() {
    _userCollection = _db.collection('users').withConverter<UserModel>(
        fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
        toFirestore: (userModel, _) => userModel.toJson());
    _messageCollection = _db.collection('messages');
  }

  FirebaseFirestore get getDB => _db;

  CollectionReference? get getUsersCollection => _userCollection;
  CollectionReference? get getMessagesCollection => _messageCollection;
}
