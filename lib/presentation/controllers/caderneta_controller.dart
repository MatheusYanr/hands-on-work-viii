import 'package:flutter/foundation.dart';
import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/usecases/register_customer.dart';
import 'package:caderneta_digital_fiado/domain/usecases/record_purchase.dart';
import 'package:caderneta_digital_fiado/domain/usecases/process_payment.dart';

/// Controller desacoplado que orquestra as regras financeiras para a interface Flutter
class CadernetaController extends ChangeNotifier {
  final RegisterCustomer registerCustomerUseCase;
  final RecordPurchase recordPurchaseUseCase;
  final ProcessPayment processPaymentUseCase;

  List<Customer> _customers = [];
  List<Customer> get customers => List.unmodifiable(_customers);

  String? errorMessage;
  bool isLoading = false;

  CadernetaController({
    required this.registerCustomerUseCase,
    required this.recordPurchaseUseCase,
    required this.processPaymentUseCase,
  });

  Future<void> cadastrarCliente({
    required String id,
    required String name,
    required String phone,
    required double limit,
  }) async {
    _setLoading(true);
    try {
      final customer = await registerCustomerUseCase(
        id: id,
        name: name,
        phone: phone,
        creditLimit: limit,
      );
      _customers = [..._customers, customer];
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> registrarCompra({
    required String customerId,
    required double amount,
    required String description,
  }) async {
    _setLoading(true);
    try {
      final result = await recordPurchaseUseCase(
        customerId: customerId,
        amount: amount,
        description: description,
      );
      _replaceCustomer(result.customer);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> baixarPagamento({
    required String customerId,
    required double amount,
  }) async {
    _setLoading(true);
    try {
      final result = await processPaymentUseCase(
        customerId: customerId,
        amount: amount,
      );
      _replaceCustomer(result.customer);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      _setLoading(false);
    }
  }

  void _replaceCustomer(Customer updated) {
    _customers = _customers.map((c) => c.id == updated.id ? updated : c).toList();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
