import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../widgets/input.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  @override
  loginState createState() => loginState();
}

class loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  // validação do form
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> enviar() async {
    // async pq requisição hhttp demora
    if (!_formKey.currentState!.validate()) return;
    // verifica se os dados do formulario estao falidos

    final usuario = {
      "senha": senhaController.text,
      "email": emailController.text,
    };

    final resposta = await http.post(
      Uri.parse('http://localhost:3000/usuario/login'),
      headers: {"Content-Type": "application/json"},
      // especifica que e json
      body: jsonEncode(usuario),
      // converte para json
    );

    // verifica o erro
    final mensagem = resposta.statusCode == 201
        ? "uuu deu certo e tem um novo usuario"
        : "vish deu ruim boa sorte ai";

    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensagem)));
    // adicona a mensagem no scaffold

    // autuaçoza caso de certo e limpa controller
    if (resposta.statusCode == 201) {
      senhaController.clear();
      emailController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
        // <- evita o erro de overflow
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                InputField(
                  controller: emailController,
                  titulo: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  obscure: false,
                ),
                const SizedBox(height: 16),
                InputField(
                  controller: senhaController,
                  titulo: 'Senha',
                  obscure: true,
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: enviar,
                  child: Text('Entrar'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {},
                  child: const Text('Não tem conta? Cadastre-se'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
