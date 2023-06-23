import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sql_conn/sql_conn.dart';
import '../shared_pref.dart';
import '../state_data.dart';
final SharedPref _sharedPref = SharedPref();

class SqlConnectService{

  Future<bool> sqlConnect(context,String ip, String port, String databaseName,String filePath,
      String username, String password) async {
    print(ip+port+databaseName+username+password);
  /*  await Provider.of<StateData>(context, listen: false)
        .changeIsConnected(false);
    await Provider.of<StateData>(context, listen: false)
        .changeIsNotConnected(false);*/
    try {
      await SqlConn.connect(
          ip: ip,
          port: port,
          databaseName: databaseName,
          username: username,
          password: password);
     // await _evrakSayimService.getEvrak(context);
      /*await Provider.of<StateData>(context, listen: false)
          .changeIsConnected(true);*/
      await _sharedPref.setBool("registeredSql", true);
      await _sharedPref.setString(
          "ip", ip);
      await _sharedPref.setString(
          "port", port);
      await _sharedPref.setString(
          "databaseName", databaseName);
      await _sharedPref.setString("filePath", filePath);
      await _sharedPref.setString(
          "userName", username);
      await _sharedPref.setString(
          "password", password);
      print("Bağlantı başarılı");
      return (SqlConn.isConnected);
    } catch (e) {
      debugPrint(e.toString());


    /*  await Provider.of<StateData>(context, listen: false)
          .changeIsNotConnected(true);*/
      return false;
    }
  }

  Future<bool> _sqlConnect(context,String ip, String port, String database,
      String filePath, String username, String password) async {
    print(ip + port + database+ username + password);

    try {
      bool a = await sqlConnect(
          context,
          ip,
          port,
          database,
          filePath,
          username,
          password);

      /*setState(() {
        isLoading = false;
      });*/
      return a;
    } catch (e) {
      /*debugPrint(e.toString());
      setState(() {
        isLoading = false;
      });*/
      return false;
    }
  }
  Future<void> sharedConn(context) async {
    /*setState(() {
      isLoading = true;
    });*/

    var registeredSql = await _sharedPref.getBool("registeredSql");
    if (registeredSql == true) {
      var ip = await _sharedPref.getString("ip");
      var port = await _sharedPref.getString("port");
      var databaseName = await _sharedPref.getString("databaseName");
      var filePath=await _sharedPref.getString("filePath");
      var username = await _sharedPref.getString("userName");
      var password = await _sharedPref.getString("password");

      await _sqlConnect(context,ip, port, databaseName,filePath, username, password);
    } else {
      /*setState(() {
        isLoading = false;
      });*/
    }
  }

}