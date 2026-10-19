import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:caderneta_digital_fiado/core/errors/failures.dart';
import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/entities/credit_transaction.dart';
import 'package:caderneta_digital_fiado/domain/repositories/customer_repository.dart';
import 'package:caderneta_digital_fiado/domain/usecases/process_payment.dart';

class MockCustomerRepository extends Mock implements CustomerRepository {}

void main() {
  late ProcessPayment useCase;
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
    useCase = ProcessPayment(mockRepository);
  });

  group('ProcessPayment UseCase [TDD - Red/Green]', () {
    final tCustomerWithDebt = Customer(
      id: 'cust-1',
      name: 'Seu Raimundo',
      phone: '11977776666',
      creditLimit: 300.0,
      currentDebt: 120.0,
    );

    test('deve amortizar pagamento parcial com sucesso subtraindo do saldo devedor', () async {
      when(() => mockRepository.getCustomerById('cust-1'))
          .thenAnswer((_) async => tCustomerWithDebt);
      when(() => mockRepository.updateCustomer(any()))
          .thenAnswer((invocation) async => invocation.positionalArguments.first as Customer);
      when(() => mockRepository.saveTransaction(any()))
          .thenAnswer((invocation) async => invocation.positionalArguments.first as CreditTransaction);

      final result = await useCase(
        customerId: 'cust-1',
        amount: 50.0,
      );

      // 120.0 - 50.0 = 70.0
      expect(result.customer.currentDebt, 70.0);
      expect(result.customer.availableCredit, 230.0);
      expect(result.transaction.amount, 50.0);
      expect(result.transaction.type, TransactionType.payment);

      verify(() => mockRepository.getCustomerById('cust-1')).called(1);
      verify(() => mockRepository.updateCustomer(any())).called(1);
      verify(() => mockRepository.saveTransaction(any())).called(1);
    });

    test('deve quitar integralmente a conta fiada deixando saldo zerado', () async {
      when(() => mockRepository.getCustomerById('cust-1'))
          .thenAnswer((_) async => tCustomerWithDebt);
      when(() => mockRepository.updateCustomer(any()))
          .thenAnswer((invocation) async => invocation.positionalArguments.first as Customer);
      when(() => mockRepository.saveTransaction(any()))
          .thenAnswer((invocation) async => invocation.positionalArguments.first as CreditTransaction);

      final result = await useCase(
        customerId: 'cust-1',
        amount: 120.0,
      );

      expect(result.customer.currentDebt, 0.0);
      expect(result.customer.availableCredit, 300.0);
    });

    test('deve falhar com PaymentExceedsDebtFailure quando pagamento é maior que a dívida', () async {
      when(() => mockRepository.getCustomerById('cust-1'))
          .thenAnswer((_) async => tCustomerWithDebt);

      // Dívida é 120. Tenta pagar 150.
      expect(
        () => useCase(
          customerId: 'cust-1',
          amount: 150.0,
        ),
        throwsA(isA<PaymentExceedsDebtFailure>()),
      );

      verifyNever(() => mockRepository.updateCustomer(any()));
    });

    test('deve falhar com InvalidTransactionAmountFailure quando valor pago for <= 0', () async {
      expect(
        () => useCase(
          customerId: 'cust-1',
          amount: 0.0,
        ),
        throwsA(isA<InvalidTransactionAmountFailure>()),
      );

      expect(
        () => useCase(
          customerId: 'cust-1',
          amount: -20.0,
        ),
        throwsA(isA<InvalidTransactionAmountFailure>()),
      );
    });

    test('deve falhar com CustomerNotFoundFailure caso o cliente não seja encontrado', () async {
      when(() => mockRepository.getCustomerById('inexistente'))
          .thenAnswer((_) async => null);

      expect(
        () => useCase(
          customerId: 'inexistente',
          amount: 10.0,
        ),
        throwsA(isA<CustomerNotFoundFailure>()),
      );
    });
  });
}
