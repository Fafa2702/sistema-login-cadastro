import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String titulo;
  final bool obscure;
  final TextInputType keyboardType;
  // validator 2.0 feito pelo gpt e pelo douglas
  const InputField({
    super.key,
    required this.controller,
    required this.titulo,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool mostrasenha = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscure && !mostrasenha,
      validator: (value) =>
          value == null || value.isEmpty ? 'Preencha o campo' : null,
      decoration: InputDecoration(
        labelText: widget.titulo,
        border: const OutlineInputBorder(),
        // senha
        suffixIcon: widget.obscure
            ? IconButton(
                icon: Icon(
                  mostrasenha ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    mostrasenha = !mostrasenha;
                  });
                },
              )
            : null,
      ),
    );
  }
}
