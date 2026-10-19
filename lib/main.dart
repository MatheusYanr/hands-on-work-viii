import 'package:flutter/material.dart';
import 'package:caderneta_digital_fiado/domain/repositories/customer_repository.dart';
import 'package:caderneta_digital_fiado/domain/usecases/register_customer.dart';
import 'package:caderneta_digital_fiado/domain/usecases/record_purchase.dart';
import 'package:caderneta_digital_fiado/presentation/controllers/caderneta_controller.dart';
import 'package:caderneta_digital_fiado/presentation/pages/home_page.dart';

void main() {
  // TODO (Matheus): Instanciar a implementação da Camada de Dados (ex: CustomerRepositoryImpl)
  // final repository = CustomerRepositoryImpl();
  throw UnimplementedError(
    'Aguardando implementação da Camada de Dados por Matheus (lib/data/repositories/customer_repository_impl.dart).'
  );
}

class CadernetaApp extends StatelessWidget {
  final CadernetaController controller;

  const CadernetaApp({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caderneta Digital de Fiado',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: HomePage(controller: controller),
    );
  }
}
