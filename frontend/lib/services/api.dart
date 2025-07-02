import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class conexao {
  final String API = "http://localhost:3000";

  Future<List<dynamic>> fetchUsers() async {
    try {
      final saida = await http.get(Uri.parse('$API/usuario'));
      if (saida.statusCode == 200) {
        print('deu certo a conexão');
        return jsonDecode(saida.body);
      } else {
        print("deu erro de novo ${saida.statusCode}");
        throw Exception('erooo: ${saida.statusCode}');
      }
    } catch (e) {
      throw Exception('erooo de conexão');
    }
  }
}
