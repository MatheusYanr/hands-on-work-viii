import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/repositories/customer_repository.dart';
import 'package:caderneta_digital_fiado/domain/usecases/register_customer.dart';

class MockCustomerRepository extends Mock implements CustomerRepository {}

void main() {
  late RegisterCustomer useCase;
  late MockCustomerRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(
      Customer(
        id: 'fallback-id',
        name: 'Fallback',
        phone: '00000000',
        creditLimit: 100.0,
      ),
    );
  });

  setUp(() {
    mockRepository = MockCustomerRepository();
    useCase = RegisterCustomer(mockRepository);
  });

  group('RegisterCustomer UseCase [TDD - Red/Green]', () {
    test('deve cadastrar um novo cliente com saldo zerado e persistir no repositório', () async {
      final tCustomer = Customer(
        id: 'cust-10',
        name: 'Antônio Ferreira',
        phone: '11999998888',
        creditLimit: 500.0,
      );

      when(() => mockRepository.saveCustomer(any()))
          .thenAnswer((_) async => tCustomer);

      final result = await useCase(
        id: 'cust-10',
        name: 'Antônio Ferreira',
        phone: '11999998888',
        creditLimit: 500.0,
      );

      expect(result, equals(tCustomer));
      expect(result.currentDebt, 0.0);
      verify(() => mockRepository.saveCustomer(any())).called(1);
    });
  });
}
