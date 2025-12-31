import 'package:cloud_firestore/cloud_firestore.dart';

class DriverService {
  final CollectionReference _driversCollection = FirebaseFirestore.instance
      .collection('drivers');

  Future<void> createDriver(String uid, String name, String email) async {
    return await _driversCollection.doc(uid).set({
      'name': name.isEmpty ? 'Motorista' : name,
      'email': email,
      'activeTripId': null,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateDriverOnLogin(String uid) async {
    return await _driversCollection.doc(uid).update({
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Stream<DocumentSnapshot> getDriverProfile(String uid) {
    return _driversCollection.doc(uid).snapshots();
  }
}
