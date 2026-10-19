import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:caderneta_digital_fiado/core/errors/failures.dart';
import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/entities/credit_transaction.dart';
import 'package:caderneta_digital_fiado/domain/repositories/customer_repository.dart';
import 'package:caderneta_digital_fiado/domain/usecases/record_purchase.dart';

class MockCustomerRepository extends Mock implements CustomerRepository {}

void main() {
  late RecordPurchase useCase;
  late MockCustomerRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(
      Customer(
        id: 'fallback-id',
        name: 'Fallback',
        phone: '00000000',
        creditLimit: 500.0,
      ),
    );
  });

  setUp(() {
    mockRepository = MockCustomerRepository();
    useCase = RecordPurchase(mockRepository);
  });

  group('RecordPurchase UseCase [TDD - Red/Green]', () {
    final tCustomer = Customer(
      id: 'cust-1',
      name: 'Dona Maria',
      phone: '11988887777',
      creditLimit: 200.0,
      currentDebt: 50.0,
    );

    test('deve registrar compra fiada com sucesso somando ao saldo devedor existente', () async {
      when(() => mockRepository.getCustomerById('cust-1'))
          .thenAnswer((_) async => tCustomer);
      when(() => mockRepository.updateCustomer(any()))
          .thenAnswer((invocation) async => invocation.positionalArguments.first as Customer);
      when(() => mockRepository.saveTransaction(any()))
          .thenAnswer((invocation) async => invocation.positionalArguments.first as CreditTransaction);

      final result = await useCase(
        customerId: 'cust-1',
        amount: 35.50,
        description: '2kg de Arroz e Feijão',
      );

      expect(result.customer.currentDebt, 85.50);
      expect(result.transaction.amount, 35.50);
      expect(result.transaction.type, TransactionType.purchase);
      expect(result.transaction.description, '2kg de Arroz e Feijão');

      verify(() => mockRepository.getCustomerById('cust-1')).called(1);
      verify(() => mockRepository.updateCustomer(any())).called(1);
      verify(() => mockRepository.saveTransaction(any())).called(1);
    });

    test('deve falhar com CreditLimitExceededFailure quando a compra estoura o limite do comerciante', () async {
      when(() => mockRepository.getCustomerById('cust-1'))
          .thenAnswer((_) async => tCustomer);

      // Cliente tem 50 de dívida e limite de 200. Tenta comprar 160 (total 210 > 200)
      expect(
        () => useCase(
          customerId: 'cust-1',
          amount: 160.0,
          description: 'Cesta Básica Completa',
        ),
        throwsA(isA<CreditLimitExceededFailure>()),
      );

      verifyNever(() => mockRepository.updateCustomer(any()));
    });

    test('deve falhar com InvalidTransactionAmountFailure quando valor for zero ou negativo', () async {
      expect(
        () => useCase(
          customerId: 'cust-1',
          amount: 0.0,
          description: 'Inválido',
        ),
        throwsA(isA<InvalidTransactionAmountFailure>()),
      );

      expect(
        () => useCase(
          customerId: 'cust-1',
          amount: -15.0,
          description: 'Negativo',
        ),
        throwsA(isA<InvalidTransactionAmountFailure>()),
      );
    });

    test('deve falhar com CustomerNotFoundFailure se o cliente não for localizado', () async {
      when(() => mockRepository.getCustomerById('inexistente'))
          .thenAnswer((_) async => null);

      expect(
        () => useCase(
          customerId: 'inexistente',
          amount: 25.0,
          description: 'Pão francês',
        ),
        throwsA(isA<CustomerNotFoundFailure>()),
      );
    });
  });
}
