import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:validar_form/common/enums.dart';
import 'dart:io';
import 'package:docx_template/docx_template.dart';
import 'package:validar_form/widgets/components/text_field_base.dart';

class FormUserScreen extends StatelessWidget {
  FormUserScreen({super.key});

  TextEditingController ctrlName = TextEditingController();
  TextEditingController ctrlFolioIne = TextEditingController();
  TextEditingController ctrlAddress = TextEditingController();
  TextEditingController ctrlRFC = TextEditingController();
  TextEditingController ctrlNumberPhone = TextEditingController();
  TextEditingController ctrlEmail = TextEditingController();
  TextEditingController ctrlHechos = TextEditingController();
  TextEditingController ctrlPruebasDocs = TextEditingController();
  TextEditingController ctrlPruebaElec = TextEditingController();
  TextEditingController ctrlLugarFecha = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Datos Denunciante"),),
        body: Form(
          key: keyForm,
          child: ListView(
            children: [
              TextFieldBase("Nombre Completo", ctrlName,
                  validateText: ValidateText.name),
              TextFieldBase("Número Folio INE", ctrlFolioIne,
                  validateText: ValidateText.folioIne),
              TextFieldBase("Domicilio", ctrlAddress,
                  validateText: ValidateText.address),
              TextFieldBase("RFC", ctrlRFC,
                  validateText: ValidateText.rfc),
              TextFieldBase("Número telefónico", ctrlNumberPhone,
                  validateText: ValidateText.phoneNumber),
              TextFieldBase("Correo Electrónico", ctrlEmail,
                  validateText: ValidateText.email),
              TextFieldBase("Hechos", ctrlHechos,
                  validateText: ValidateText.hechos),
              TextFieldBase("Pruebas Documentales", ctrlPruebasDocs,
                  validateText: ValidateText
                      .pruebasDocs), //Si no es requerido se pone al final: notRequire: true,
              TextFieldBase("Prueba Electrónica", ctrlPruebaElec,
                  validateText: ValidateText.pruebaElec),
              TextFieldBase("Ciudad, Estado Fecha", ctrlLugarFecha,
                  validateText: ValidateText.lugarFecha),
              TextButton(onPressed: save, child: Text("Guardar")),
              TextButton(
                  onPressed: limpiarFormulario,
                  child: Text("Limpiar Formulario"))
            ],),));}
  save() async {
     if (keyForm.currentState!.validate()) {
    // Cargar la plantilla desde activos
    final templateBytes = await rootBundle.load('assets/templates/denuncia.docx');
    final docx = await DocxTemplate.fromBytes(templateBytes.buffer.asUint8List());

    // Crear un directorio temporal para almacenar el archivo resultante
    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;

    Content content = Content();
    content
      ..add(TextContent("LugarFecha", ctrlLugarFecha.text))
      ..add(TextContent("NombreCompleto", ctrlName.text))      
      ..add(TextContent("Folio", ctrlFolioIne.text))
      ..add(TextContent("Domicilio", ctrlAddress.text))
      ..add(TextContent("RFC", ctrlRFC.text))
      ..add(TextContent("Email", ctrlEmail.text))
      ..add(TextContent("NumTel", ctrlNumberPhone.text))      
      ..add(TextContent("Hechos", ctrlHechos.text))
      ..add(TextContent("PruebasDocs", ctrlPruebasDocs.text))
      ..add(TextContent("PruebaElec", ctrlPruebaElec.text));
    // Generar el archivo resultante
    final resultBytes = await docx.generate(content);

    if (resultBytes != null) {
      // Guardar el archivo resultante en el directorio temporal
      final resultFile = File('$tempPath/resultante.docx');
      await resultFile.writeAsBytes(resultBytes);
      // Imprimir la ruta donde se guardó el archivo (para verificar)
      print('Documento guardado con éxito en ${resultFile.path}');
    } else {
      print('Error: resultBytes es null');
    }}}
  limpiarFormulario() {
    ctrlName.clear();
    ctrlAddress.clear();
    ctrlEmail.clear();
    ctrlFolioIne.clear();
    ctrlHechos.clear();
    ctrlNumberPhone.clear();
    ctrlPruebasDocs.clear();
    ctrlRFC.clear();
    ctrlPruebaElec.clear();
    ctrlLugarFecha.clear();
  }}
