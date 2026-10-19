/// Classe base para todas as falhas e exceções de regra de negócio
abstract class DomainFailure implements Exception {
  final String message;
  const DomainFailure(this.message);

  @override
  String toString() => message;
}

/// Disparada quando dados de entrada do cliente violam restrições do sistema
class InvalidCustomerDataFailure extends DomainFailure {
  const InvalidCustomerDataFailure(super.message);
}

/// Disparada quando uma operação financeira tenta debitar ou creditar valores inválidos
class InvalidTransactionAmountFailure extends DomainFailure {
  const InvalidTransactionAmountFailure(super.message);
}

/// Disparada quando o fiado ultrapassa o teto máximo de crédito aprovado
class CreditLimitExceededFailure extends DomainFailure {
  const CreditLimitExceededFailure(super.message);
}

/// Disparada quando a amortização ultrapassa o saldo devedor existente
class PaymentExceedsDebtFailure extends DomainFailure {
  const PaymentExceedsDebtFailure(super.message);
}

/// Disparada quando um cliente não é localizado na base
class CustomerNotFoundFailure extends DomainFailure {
  const CustomerNotFoundFailure(super.message);
}
