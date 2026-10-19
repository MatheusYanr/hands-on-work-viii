import 'package:flutter/material.dart';
import 'package:caderneta_digital_fiado/data/repositories/in_memory_customer_repository.dart';
import 'package:caderneta_digital_fiado/domain/usecases/register_customer.dart';
import 'package:caderneta_digital_fiado/domain/usecases/record_purchase.dart';
import 'package:caderneta_digital_fiado/domain/usecases/process_payment.dart';
import 'package:caderneta_digital_fiado/presentation/controllers/caderneta_controller.dart';
import 'package:caderneta_digital_fiado/presentation/pages/home_page.dart';

void main() {
  final repository = InMemoryCustomerRepository();
  final controller = CadernetaController(
    registerCustomerUseCase: RegisterCustomer(repository),
    recordPurchaseUseCase: RecordPurchase(repository),
    processPaymentUseCase: ProcessPayment(repository),
  );

  runApp(CadernetaApp(controller: controller));
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
