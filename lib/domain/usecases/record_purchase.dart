import 'package:caderneta_digital_fiado/core/errors/failures.dart';
import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/entities/credit_transaction.dart';
import 'package:caderneta_digital_fiado/domain/repositories/customer_repository.dart';

class PurchaseResult {
  final Customer customer;
  final CreditTransaction transaction;

  const PurchaseResult({
    required this.customer,
    required this.transaction,
  });
}

/// Caso de Uso: Registrar nova compra no fiado
class RecordPurchase {
  final CustomerRepository repository;

  RecordPurchase(this.repository);

  Future<PurchaseResult> call({
    required String customerId,
    required double amount,
    required String description,
  }) async {
    if (amount <= 0) {
      throw const InvalidTransactionAmountFailure(
        'O valor da compra deve ser estritamente maior que zero.',
      );
    }

    final customer = await repository.getCustomerById(customerId);
    if (customer == null) {
      throw const CustomerNotFoundFailure('Cliente não encontrado.');
    }

    // Delega a regra de negócio e validação de limite à própria entidade de domínio
    final updatedCustomer = customer.increaseDebt(amount);

    final transaction = CreditTransaction(
      id: 'tx-${DateTime.now().microsecondsSinceEpoch}',
      customerId: customerId,
      amount: amount,
      type: TransactionType.purchase,
      description: description,
      timestamp: DateTime.now(),
    );

    await repository.updateCustomer(updatedCustomer);
    await repository.saveTransaction(transaction);

    return PurchaseResult(
      customer: updatedCustomer,
      transaction: transaction,
    );
  }
}
