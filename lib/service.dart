import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Service {
  static const String baseUrl = "http://localhost:8080/api/users";

  Future<http.Response> saveUser(
      String name, String mobile, String email, String address) async {
    var uri = Uri.parse(baseUrl);
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'name': '$name',
      'email': '$email',
      'mobile': '$mobile',
      'address': '$address',
    };
    var body = json.encode(data);
    var response = await http.post(uri, headers: headers, body: body);
    return response;
    
  }

  Future<http.Response> updateUser(
      String id, String name, String mobile, String email, String address) async {
    var uri = Uri.parse('$baseUrl/$id');
    Map<String, String> headers = {"Content-Type": "application/json"};
    Map data = {
      'name': '$name',
      'email': '$email',
      'mobile': '$mobile',
      'address': '$address',
    };
    var body = json.encode(data);
    var response = await http.put(uri, headers: headers, body: body);
    return response;
  }

  Future<http.Response> deleteUser(String id) async {
    var uri = Uri.parse('$baseUrl/$id');
    var response = await http.delete(uri);
    return response;
  }

  Future<List<User>> getUsers() async {
    var uri = Uri.parse(baseUrl);
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      address: json['address'],
    );
  }
}
