import 'dart:io';
import 'dart:convert';
import 'package:paml_exe2/models/kuliner.dart';
import 'package:paml_exe2/service/kuliner_service.dart';

class KulinerController {
  final KulinerService _service = KulinerService();

  Future<Map<String, dynamic>> addPerson(Kuliner person, File? file) async {
    Map<String, String> data = {
      'nama': person.nama,
      'alamat': person.alamat,
    };

    try {
      var response = await _service.addPerson(data, file);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': 'Data Successfuly Added',
        };
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            'message': decodedJson['message'] ?? 'There is an error!',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'An error occurred while saving data',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'There is an error! $e',
      };
    }
  }

  Future<List<Kuliner>> getPeople() async {
    try {
      List<dynamic> peopleData = await _service.fetchPeople();
      List<Kuliner> people =
          peopleData.map((json) => Kuliner.fromMap(json)).toList();
      return people;
    } catch (e) {
      print(e);
      throw Exception('Failed to get people');
    }
  }
}
