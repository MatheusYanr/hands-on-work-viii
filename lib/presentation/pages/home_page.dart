import 'package:flutter/material.dart';
import 'package:caderneta_digital_fiado/presentation/controllers/caderneta_controller.dart';

class HomePage extends StatelessWidget {
  final CadernetaController controller;

  const HomePage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caderneta Digital de Fiado 📓'),
        elevation: 2,
      ),
      body: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.customers.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum cliente cadastrado no fiado.\nCadastre um cliente para começar.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: controller.customers.length,
            itemBuilder: (context, index) {
              final customer = controller.customers[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    customer.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Contato: ${customer.phone}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Dívida: R\$ ${customer.currentDebt.toStringAsFixed(2)}',
                        style: TextStyle(
                          color: customer.currentDebt > 0 ? Colors.red : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Disp: R\$ ${customer.availableCredit.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
