import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Models/task_model.dart';

class Api extends GetxController {
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  var result;
  static const baseURL = "http://192.168.0.103/api/";

  static Future<void> addtask(Map<String, dynamic> taskData) async {
    var url = Uri.parse("${baseURL}add_task");
    try {
      final res = await http.post(url, body: taskData);
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body.toString());
        // Handle success response if needed
      } else {
        print("Failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> gettask() async {
    var url = Uri.parse("${baseURL}get_task");
    try {
      final res = await http.get(url);
      if (res.statusCode == 200) {
        result = jsonDecode(res.body);
        _isLoaded = true;
        update();
      } else {
        print("Failed to get response");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> updatetask(String id, Map<String, dynamic> updatedTaskData) async {
    var url = Uri.parse("${baseURL}update/$id");
    try {
      final res = await http.put(url, body: updatedTaskData);
      if (res.statusCode == 200) {
        result = jsonDecode(res.body);
        print("Task updated");
      } else {
        print("Failed to update data");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> deletetask(String id) async {
    var url = Uri.parse("${baseURL}delete/$id");
    try {
      final res = await http.post(url);
      if (res.statusCode == 204) {
        print(jsonDecode(res.body));
      } else {
        print("Failed to delete");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
