import 'plant_model.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class PlantRepository {
  final CollectionReference<Map<String, dynamic>> _plantas = FirebaseFirestore
      .instance
      .collection('plantas');
  Future<List<Plant>> obtenerPlantas() async {
    final snapshot = await _plantas.orderBy('nombre').get();
    return snapshot.docs
        .map((doc) => Plant.fromMap(doc.id, doc.data()))
        .toList();
  }
}
