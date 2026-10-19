import 'package:flutter/foundation.dart';
import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/usecases/register_customer.dart';
import 'package:caderneta_digital_fiado/domain/usecases/record_purchase.dart';

/// Controller da Caderneta de Fiado
/// Conecta a interface gráfica Flutter aos casos de uso da regra de negócio
class CadernetaController extends ChangeNotifier {
  final RegisterCustomer registerCustomerUseCase;
  final RecordPurchase recordPurchaseUseCase;
  // TODO (Matheus): Injetar o caso de uso ProcessPayment da segunda funcionalidade

  List<Customer> _customers = [];
  List<Customer> get customers => List.unmodifiable(_customers);

  String? errorMessage;
  bool isLoading = false;

  CadernetaController({
    required this.registerCustomerUseCase,
    required this.recordPurchaseUseCase,
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

  // TODO (Matheus): Adicionar método baixarPagamento({required String customerId, required double amount})

  void _replaceCustomer(Customer updated) {
    _customers = _customers.map((c) => c.id == updated.id ? updated : c).toList();
  }

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
