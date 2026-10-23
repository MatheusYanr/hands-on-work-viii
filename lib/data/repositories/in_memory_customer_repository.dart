import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/entities/credit_transaction.dart';
import 'package:caderneta_digital_fiado/domain/repositories/customer_repository.dart';

/// Implementação em memória do repositório (isolada e thread-safe para testes e prototipagem)
class InMemoryCustomerRepository implements CustomerRepository {
  final Map<String, Customer> _customers = {};
  final List<CreditTransaction> _transactions = [];

  @override
  Future<Customer> saveCustomer(Customer customer) async {
    _customers[customer.id] = customer;
    return customer;
  }

  @override
  Future<Customer?> getCustomerById(String id) async {
    return _customers[id];
  }

  @override
  Future<List<Customer>> getAllCustomers() async {
    return _customers.values.toList();
  }

  @override
  Future<Customer> updateCustomer(Customer customer) async {
    _customers[customer.id] = customer;
    return customer;
  }

  @override
  Future<CreditTransaction> saveTransaction(CreditTransaction transaction) async {
    _transactions.add(transaction);
    return transaction;
  }

  @override
  Future<List<CreditTransaction>> getTransactionsByCustomer(String customerId) async {
    return _transactions.where((tx) => tx.customerId == customerId).toList();
  }
}
