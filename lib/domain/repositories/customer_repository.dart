import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/entities/credit_transaction.dart';

/// Contrato de persistência para clientes e transações de fiado
abstract class CustomerRepository {
  Future<Customer> saveCustomer(Customer customer);
  Future<Customer?> getCustomerById(String id);
  Future<List<Customer>> getAllCustomers();
  Future<Customer> updateCustomer(Customer customer);

  Future<CreditTransaction> saveTransaction(CreditTransaction transaction);
  Future<List<CreditTransaction>> getTransactionsByCustomer(String customerId);
}
