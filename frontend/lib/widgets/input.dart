import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String titulo;
  final bool obscure;
  final TextInputType keyboardType;
  final Icon? icons;
  final int? maxLength;
  final FormFieldValidator<String>? validator;

  final MaskTextInputFormatter? maskFormatter;

  // validator 2.0 feito pelo gpt e pelo douglas
  const InputField(
      {super.key,
      required this.controller,
      required this.titulo,
      this.obscure = false,
      this.keyboardType = TextInputType.text,
      this.maskFormatter,
      this.validator,
      this.icons,
      this.maxLength});

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool mostrasenha = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscure && !mostrasenha,
      validator: (value) =>
          value == null || value.isEmpty ? 'Preencha o campo' : null,
      inputFormatters:
          widget.maskFormatter != null ? [widget.maskFormatter!] : [],
      decoration: InputDecoration(
        labelText: widget.titulo,
        border: const OutlineInputBorder(),
        prefixIcon: widget.icons,

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
