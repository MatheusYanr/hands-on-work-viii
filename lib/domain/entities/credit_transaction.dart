import 'package:equatable/equatable.dart';

enum TransactionType { purchase, payment }

/// Registro contábil imutável de uma movimentação financeira de fiado
class CreditTransaction extends Equatable {
  final String id;
  final String customerId;
  final double amount;
  final TransactionType type;
  final String description;
  final DateTime timestamp;

  const CreditTransaction({
    required this.id,
    required this.customerId,
    required this.amount,
    required this.type,
    required this.description,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [id, customerId, amount, type, description, timestamp];
}
