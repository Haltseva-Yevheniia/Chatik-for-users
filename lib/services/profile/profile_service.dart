import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatik_for_users/constants.dart';


class ProfileService {

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future <void> addName ({required String name}) async{

await _firebaseFirestore.collection('users').doc(currentUserId).set({

  'name': name,
}, SetOptions(merge: true),);

  }

}