import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/pages/cadastro.dart';
import '../widgets/input.dart';
import 'package:http/http.dart' as http;

class login extends StatefulWidget {
  @override
  loginState createState() => loginState();
}

// logica explicada em usuario.dart
class loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  // validação do form
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  Future<void> enviar() async {
    if (!_formKey.currentState!.validate()) return;

    final usuario = {
      "senha": senhaController.text,
      "email": emailController.text,
    };

    final resposta = await http.post(
      Uri.parse('http://172.30.0.120:3000/usuario/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(usuario),
    );

    if (resposta.statusCode == 200) {
      // Login ok: mostra modal
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('bem vindo ao app!'),
          content: const Text('login realizado com sucesso!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // fecha o modal
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );

      // Limpa campos após fechar modal
      senhaController.clear();
      emailController.clear();
    } else {
      // Erro: mostra snackbar
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Senha ou email incorretos')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: SingleChildScrollView(
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => cadastro(),
                      ),
                    );
                  },
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
