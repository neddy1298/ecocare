import 'dart:convert';

import 'package:ecocare/api/api_key.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/data.dart';

class Datas with ChangeNotifier {
  final List<Data> _allData = [];
  final String apiPath = Api.path;

  List<Data> get allData => _allData;

  int get jumlahData => _allData.length;

  Data selectById(String id) =>
      _allData.firstWhere((element) => element.id == id);

  void aturSuhu(
      String id, int heaterSpeed, int coolingSpeed, BuildContext context) {
    Data selectData = _allData.firstWhere((element) => element.id == id);
    selectData.heater_speed = heaterSpeed;
    selectData.cooling_speed = coolingSpeed;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil diubah"),
        duration: Duration(seconds: 2),
      ),
    );
    notifyListeners();
  }

  Future<void> initialData() async {
    Uri url = Uri.parse(apiPath);

    var hasilData = await http.get(url);
    var data = json.decode(hasilData.body) as Map<String, dynamic>;

    _allData.clear(); // Clear existing data to avoid duplicates

    // Directly update _allData with the single array data
    _allData.add(
      Data(
        id: 'Suhu',
        derajat: data['derajat'],
        ph: data['ph'],
        heater_speed: data['heater_speed'],
        cooling_speed: data['cooling_speed'],
        createdAt: DateTime.now(),
      ),
    );

    notifyListeners();

    // Set up realtime listener for updates
    FirebaseDatabase.instance.ref().child('ecocare').onValue.listen((event) {
      var updatedData = event.snapshot.value as Map<String, dynamic>;

      // Directly update _allData with the updated values
      _allData.clear();
      _allData.add(
        Data(
          id: 'Suhu',
          derajat: updatedData['derajat'],
          ph: updatedData['ph'],
          cooling_speed: updatedData['cooling_speed'], // Use updatedData here
          heater_speed: updatedData['heater_speed'], // Use updatedData here
          createdAt: DateTime.now(),
        ),
      );

      notifyListeners();
    });
  }
}
