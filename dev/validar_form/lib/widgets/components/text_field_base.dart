import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validar_form/common/validate.dart';
import 'package:validar_form/common/enums.dart';
import 'package:validar_form/utils/UpperCaseTextFormatter.dart';

class TextFieldBase extends StatelessWidget {
  //const TextFieldBase({super.key});
  String text;
  TextEditingController controller;
  ValidateText? validateText;
  bool notRequire;
  TextFieldBase(this.text, this.controller,
      {this.validateText, this.notRequire = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: 18.0, // Tamaño del nombre de los campos
              fontWeight: FontWeight.bold),
        ),
        Text(
          getHelperText(), //Para los textos de sugerencias en los campos del formulario.
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize:
                  11.0, // Tamaño de los mensajes de ayuda en los campos de texto.
              fontStyle: FontStyle.italic),
        ),
        TextFormField(
          controller: controller,
          maxLength: validateMaxLength(), //Validar longitud de campo
          inputFormatters: [validateInputFormatters(),
            UpperCaseTextFormatter()
          ], //Valida el tipo de dato
          validator: (String? value) {
            return validateStructure(value);
          },
        )
      ],
    );
  }

  validateMaxLength() {
    switch (validateText) {
      case ValidateText.name:
        return 40;
      case ValidateText.folioIne:
        return 13;
      case ValidateText.address:
        return 120;
      case ValidateText.rfc:
        return 13;
      case ValidateText.pruebasDocs:
        return 500;
      case ValidateText.pruebaElec:
        return 500;
      case ValidateText.email:
        return 64;
      case ValidateText.hechos:
        return 1000;
      case ValidateText.phoneNumber:
        return 10;
      case ValidateText.lugarFecha:
        return 60;
      default:
        return null;
    }
  }

  validateStructure(String? value) {
    if (!notRequire && value!.isEmpty) {
      return "El campo $text es requerido";
    } else {
      switch (validateText) {
        case ValidateText.name:
          return validateName(value!) ? null : message("Nombre");
        case ValidateText.folioIne:
          return validateFolioIne(value!) ? null : message("Número de folio");
        case ValidateText.rfc:
          return validateRFC(value!) ? null : message("RFC");
        case ValidateText.email:
          return validateEmail(value!) ? null : message("Correo electrónico");
        case ValidateText.phoneNumber:
          return validatePhoneNumber(value!)
              ? null
              : message("Número Telefónico");
        default:
          return null;
      }
    }
  }

  message(String type) => "La estructura del $type es incorrecta";

  validateInputFormatters() {
    switch (validateText) {
      case ValidateText.name:
        return FilteringTextInputFormatter.allow(
            RegExp('^[a-zA-Z ]+')); //UpperCaseTextFormatter();
      case ValidateText.folioIne:
        return FilteringTextInputFormatter.digitsOnly;
      case ValidateText.rfc:
        return UpperCaseTextFormatter();
      case ValidateText.phoneNumber:
        return FilteringTextInputFormatter.digitsOnly;
      default:
        return FilteringTextInputFormatter.singleLineFormatter;
    }
  }

  String getHelperText() {
    switch (validateText) {
      case ValidateText.phoneNumber:
        return 'Escribe los 10 dígitos de tu número telefónico, sin espacios y sin guiones.';
      case ValidateText.lugarFecha:
        return 'Ejemplo: Ciudad de México, a ${DateTime.now().day} de ${getMonthName(DateTime.now().month)} de ${DateTime.now().year}';
      case ValidateText.name:
        return 'Escribe tu(s) nombre(s) y apellidos.';
      case ValidateText.folioIne:
        return 'Consta de 13 dígitos, visibles al reverso de tu INE.';
      case ValidateText.address:
        return 'Calle #, Colonia, Alcaldía, Código Postal, Ciudad, Estado.';
      case ValidateText.rfc:
        return 'Escribe tu RFC con homoclave.';
      case ValidateText.email:
        return 'Escribe tu dirección de correo electrónico (E-mail).';
      case ValidateText.hechos:
        return 'Describe los hechos por los cuales haces está denuncia';
      case ValidateText.pruebasDocs:
        return 'Describe si presentas capturas de pantalla, correos electrónicos, números telefónicos, facturas, números de cuenta, etc.';
      case ValidateText.pruebaElec:
        return 'Describe características del dispositivo: USB, CD-DVD, marca, color, tamaño, nombre de los archivos, etc.';
      default:
        return ''; // Puedes devolver un mensaje genérico o vacío si no hay ayuda específica
    }
  }

}