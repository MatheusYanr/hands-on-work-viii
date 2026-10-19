import 'package:caderneta_digital_fiado/domain/entities/customer.dart';

/// Contrato de persistência para clientes (desacoplado do banco de dados/framework)
abstract class CustomerRepository {
  Future<Customer> saveCustomer(Customer customer);
  Future<Customer?> getCustomerById(String id);
  Future<List<Customer>> getAllCustomers();
  Future<Customer> updateCustomer(Customer customer);
}
