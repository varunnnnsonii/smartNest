import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<dynamic>> fetchData(String endpoint) async {
  final response = await http.get(Uri.parse('http://0.0.0.0:5002/'));

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception('Failed to load data');
  }
}

