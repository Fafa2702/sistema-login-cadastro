import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'auth.dart';

// serve para fazer requicisões de get e post em rotas protegidas (nenhuma criada no back mais ja adiantei)
class conexao {
  static const String API = "http://localhost:3000";

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

  // GET com token
  static Future<http.Response> get(String rota) async {
    final token = await autentificacao.getToken();
    // pega token do usuario
    return http.get(
      Uri.parse('$API$rota'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      // manda o token
    );
  }

  // POST com token - mesma coisa de cima so que post
  static Future<http.Response> post(String rota, dynamic body) async {
    final token = await autentificacao.getToken();
    return http.post(
      Uri.parse('$API$rota'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: body,
    );
  }
}
