import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sharikiapp/models/connect.dart';
import 'package:sharikiapp/styles.dart';
import 'package:sharikiapp/widgets/loading/fetching_data.dart';

class ConnectionProvider with ChangeNotifier {
  Connect _connection = Connect(baseUrl: "http://localhost:4000/");
  Connect get connection => _connection;

  Future<bool> checkConnectivity(BuildContext context) async {
    bool isConnected = false;
    print("Checking...");
    try {
      final response = await http.get(Uri.parse(_connection.baseUrl));
      isConnected = true;
    } catch (e) {
      print("Problem in connection");
      isConnected = false;
      await Future.delayed(const Duration(seconds: 2), (){
        FetchingDataLoading.scaffoldKey.currentState!.showSnackBar(
          SnackBar(
        content: Text("هناك مشكلة بالاتصال بالشبكة"),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: "حسنًا",
          textColor: primaryColor,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar,
        ),
      ),
        );
      });
    }
    print(isConnected);
    return isConnected;
  }
}
