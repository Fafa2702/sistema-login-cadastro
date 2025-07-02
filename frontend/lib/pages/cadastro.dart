import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/pages/login.dart';
import '../widgets/input.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:http/http.dart' as http;

class cadastro extends StatefulWidget {
  @override
  cadastroState createState() => cadastroState();
}

class cadastroState extends State<cadastro> {
  final _formKey = GlobalKey<FormState>(); // validação do form

  // controlers
  final TextEditingController senhaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();

  // maskara de telefone
  final maskTelefone = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  Future<void> enviar() async {
    if (!_formKey.currentState!.validate()) return;

    // pega os usuarios do controller e envia para o banco de dados
    final usuario = {
      "senha": senhaController.text,
      "name": nameController.text,
      "telefone": telefoneController.text,
      "email": emailController.text,
    };

    // pega os dados e envia para a rota que vai execultar um POSt
    final resposta = await http.post(
      Uri.parse('http://172.30.0.120:3000/usuario'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(usuario),
    );

    if (resposta.statusCode == 201) {
      // se a senha e o email forem validos mostra o modal

      await modalCadastro(context); // chamando modal cadastro

      // Limpa campos após fechar modal
      senhaController.clear();
      nameController.clear();
      telefoneController.clear();
      emailController.clear();
    } else {
      // eroo mostra snackbar
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("tente de novo ")));
    }
  }

// modal de cadastro
  Future<void> modalCadastro(BuildContext context) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // impede fechar tocando fora do alerta
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Parabéns',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  const Text('Cadastro realizado com sucesso!'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    },
                    child: const Text('Ir para tela de login'),
                  ),
                ],
              ),
            ),
            // Botão de fechar (X) no topo direito
            Positioned(
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro')),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  InputField(
                    controller: nameController,
                    titulo: 'name',
                    // maxLength: 50,
                    icons: Icon(Icons.person),
                    obscure: false,
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    controller: emailController,
                    titulo: 'email',
                    icons: Icon(Icons.email),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Digite um e-mail';
                      } // obrigatorio o uso desse para nao ser null
                      if (!value.contains('@')) {
                        return 'Email inválido';
                      }
                      return null;
                    },
                    obscure: false,
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    controller: telefoneController,
                    titulo: 'telefone',
                    icons: Icon(Icons.phone),
                    maskFormatter: maskTelefone,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (maskTelefone.getUnmaskedText().length != 11)
                        return 'Telefone inválido';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  InputField(
                    controller: senhaController,
                    // maxLength: 10,
                    keyboardType: TextInputType.number,
                    titulo: 'senha',
                    icons: Icon(Icons.password_outlined),
                    obscure: true,
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: enviar,
                    child: Text('enviar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
