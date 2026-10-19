import 'package:equatable/equatable.dart';
import 'package:caderneta_digital_fiado/core/errors/failures.dart';

/// Entidade de Domínio: Cliente da Caderneta de Fiado
/// Modela dados e invariantes de integridade do cliente
class Customer extends Equatable {
  final String id;
  final String name;
  final String phone;
  final double creditLimit;
  final double currentDebt;

  Customer({
    required this.id,
    required String name,
    required this.phone,
    required this.creditLimit,
    this.currentDebt = 0.0,
  }) : name = name.trim() {
    _validateInvariants();
  }

  void _validateInvariants() {
    if (name.isEmpty) {
      throw const InvalidCustomerDataFailure('O nome do cliente não pode estar em branco.');
    }
    if (creditLimit <= 0) {
      throw const InvalidCustomerDataFailure('O limite de crédito do fiado deve ser superior a zero.');
    }
    if (currentDebt < 0) {
      throw const InvalidCustomerDataFailure('O saldo devedor não pode ser negativo.');
    }
  }

  /// Limite de crédito ainda disponível para novas compras no fiado
  double get availableCredit => (creditLimit - currentDebt).clamp(0.0, creditLimit);

  /// Verifica se o cliente possui margem disponível para determinado valor
  bool canAfford(double amount) => (currentDebt + amount) <= creditLimit;

  /// Retorna nova instância imutável com novo saldo devedor
  Customer copyWithDebt(double newDebt) {
    return Customer(
      id: id,
      name: name,
      phone: phone,
      creditLimit: creditLimit,
      currentDebt: newDebt,
    );
  }

  @override
  List<Object?> get props => [id, name, phone, creditLimit, currentDebt];
}
