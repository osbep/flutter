import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MyPdfGuia extends StatefulWidget {
  const MyPdfGuia({super.key});

  @override
  State<MyPdfGuia> createState() => _MyPdfGuiaState();
}

class _MyPdfGuiaState extends State<MyPdfGuia> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Guía de usuario"),       
      ),
      body: SfPdfViewer.asset("assets/templates/guia.pdf")
    );
  }
}