import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// classe usuario e requisição do banco
class Usuario {
  final String id;
  final String nome;
  final String senha;
  final String email;
  final String telefone;

  Usuario(
      {required this.id,
      required this.nome,
      required this.senha,
      required this.email,
      required this.telefone});

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
      id: json["id"],
      nome: json["name"],
      telefone: json["telefone"],
      email: json["email"],
      senha: json["senha"]);
}
