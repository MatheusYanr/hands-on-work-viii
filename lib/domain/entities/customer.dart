import 'package:equatable/equatable.dart';
import 'package:caderneta_digital_fiado/core/errors/failures.dart';

/// Entidade que representa o cliente da caderneta de fiado
class Customer extends Equatable {
  final String id;
  final String name;
  final String phone;
  final double creditLimit;
  final double currentDebt;

  Customer({
    required this.id,
    required this.name,
    required this.phone,
    required this.creditLimit,
    this.currentDebt = 0.0,
  }) {
    if (name.trim().isEmpty) {
      throw const InvalidCustomerDataFailure('O nome do cliente não pode estar em branco.');
    }
    if (creditLimit <= 0) {
      throw const InvalidCustomerDataFailure('O limite de crédito do fiado deve ser superior a zero.');
    }
    if (currentDebt < 0) {
      throw const InvalidCustomerDataFailure('O saldo devedor não pode ser negativo.');
    }
  }

  /// Limite de crédito ainda disponível para novos fiados
  double get availableCredit => creditLimit - currentDebt;

  /// Cria uma nova instância com saldo modificado (imutabilidade)
  Customer copyWith({
    String? id,
    String? name,
    String? phone,
    double? creditLimit,
    double? currentDebt,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      creditLimit: creditLimit ?? this.creditLimit,
      currentDebt: currentDebt ?? this.currentDebt,
    );
  }

  @override
  List<Object?> get props => [id, name, phone, creditLimit, currentDebt];
}
