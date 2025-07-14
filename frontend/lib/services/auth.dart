import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// faz login e cadstro usando http e salva o token com função de biblioteca do flutter

class autentificacao {
  // storage e um armazenamento de dados locais essa função em especifico
  // armazena dados cripitorafados e confidenciais
  static final armazenamento = FlutterSecureStorage();

  // função de login
  static Future<bool> Login(String email, String senha) async {
    final saida = await http.post(
      Uri.parse('http://172.30.0.120:3000/usuario/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'senha': senha}),
    );

    if (saida.statusCode == 200) {
      final data = jsonDecode(saida.body);
      await armazenamento.write(key: 'token', value: data['token']);
      print(saida.body);
      return true;
    } else {
      print("affs deu erro ${saida.statusCode}");
      return false;
    }
  }

  // função cadastro
  static Future<bool> cadastrar(Map<String, dynamic> usuario) async {
    final cadastrar = await http.post(
      Uri.parse('http://172.30.0.120:3000/usuario'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(usuario),
    );

    if (cadastrar.statusCode == 200) {
      final data = jsonDecode(cadastrar.body);
      await armazenamento.write(key: 'token', value: data['token']);
      print(cadastrar.body);
      return true;
    } else {
      print("affs deu erro ${cadastrar.statusCode}");
      return false;
    }
  }

  // função logout
  static Future<void> logout() async {
    await armazenamento.delete(key: 'token');
    // deleta o token que armazenamos ao o usuario logar ou seja ele desloga e para criar outro token so logando
  }

  static Future<String?> getToken() async {
    return await armazenamento.read(key: 'token');
  }
}
