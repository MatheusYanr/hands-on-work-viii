import 'package:caderneta_digital_fiado/core/errors/failures.dart';
import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/entities/credit_transaction.dart';
import 'package:caderneta_digital_fiado/domain/repositories/customer_repository.dart';

class PaymentResult {
  final Customer customer;
  final CreditTransaction transaction;

  const PaymentResult({
    required this.customer,
    required this.transaction,
  });
}

/// Caso de Uso: Processar pagamento e amortizar dívida de fiado
/// - Valida valor estritamente positivo
/// - Garante que o pagamento não exceda a dívida atual do cliente
/// - Deduz o saldo devedor e registra a transação financeira
class ProcessPayment {
  final CustomerRepository repository;

  ProcessPayment(this.repository);

  Future<PaymentResult> call({
    required String customerId,
    required double amount,
    String description = 'Pagamento / Amortização de Fiado',
  }) async {
    if (amount <= 0) {
      throw const InvalidTransactionAmountFailure(
        'O valor do pagamento deve ser estritamente maior que zero.',
      );
    }

    final customer = await repository.getCustomerById(customerId);
    if (customer == null) {
      throw const CustomerNotFoundFailure('Cliente não encontrado.');
    }

    final updatedCustomer = customer.decreaseDebt(amount);

    final transaction = CreditTransaction(
      id: 'tx-pay-${DateTime.now().microsecondsSinceEpoch}',
      customerId: customerId,
      amount: amount,
      type: TransactionType.payment,
      description: description,
      timestamp: DateTime.now(),
    );

    await repository.updateCustomer(updatedCustomer);
    await repository.saveTransaction(transaction);

    return PaymentResult(
      customer: updatedCustomer,
      transaction: transaction,
    );
  }
}
