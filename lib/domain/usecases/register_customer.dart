import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/repositories/customer_repository.dart';

/// Caso de Uso: Cadastro de novo cliente com limite de crédito e dívida zerada
class RegisterCustomer {
  final CustomerRepository repository;

  RegisterCustomer(this.repository);

  Future<Customer> call({
    required String id,
    required String name,
    required String phone,
    required double creditLimit,
  }) async {
    final customer = Customer(
      id: id,
      name: name,
      phone: phone,
      creditLimit: creditLimit,
      currentDebt: 0.0,
    );

    return await repository.saveCustomer(customer);
  }
}
