import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sharikiapp/models/connect.dart';

class ConnectionProvider with ChangeNotifier {
  Connect _connection = Connect(baseUrl: "http://shariki-app.herokuapp.com/");
  Connect get connection => _connection;

  Future<bool> checkConnectivity() async {
    bool isConnected = false;
    try {
      final response = await http.get(Uri.parse(_connection.baseUrl));
      isConnected = true;
    } catch (e) {
      print("Problem in connection");
      isConnected = false;
    }
    print(isConnected);
    return isConnected;
  }
}
