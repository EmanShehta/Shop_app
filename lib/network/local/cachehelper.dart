import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CahceHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool?> PutData({
    required String? Key,
    required bool? Value,
  }) async {
    return await sharedPreferences!.setBool(Key!, Value!);
  }

 static dynamic  getData({
    required String? Key,
  }) {
    return sharedPreferences?.get(Key!);
  }
  static Future<bool?> saveData({
    required String? Key,
    required dynamic? Value,
  }) async
   {
    if (Value is String) return await sharedPreferences!.setString(Key!, Value!);
    if (Value is int) return await sharedPreferences!.setInt(Key!, Value!);
    if (Value is bool) return await sharedPreferences!.setBool(Key!, Value!);
    return  await sharedPreferences!.setDouble(Key!, Value!);
  }


 static Future<bool?> removeData
      ({
required String Key,
}) async
{
  return await sharedPreferences!.remove(Key!);
}
}
