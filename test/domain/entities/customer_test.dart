import 'package:flutter_test/flutter_test.dart';
import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/core/errors/failures.dart';

void main() {
  group('Customer Entity [TDD - Red/Green]', () {
    test('deve instanciar um cliente com saldo devedor inicial exatamente 0.0', () {
      final customer = Customer(
        id: 'cust-1',
        name: 'Dona Maria da Silva',
        phone: '11987654321',
        creditLimit: 300.0,
      );

      expect(customer.id, 'cust-1');
      expect(customer.name, 'Dona Maria da Silva');
      expect(customer.phone, '11987654321');
      expect(customer.creditLimit, 300.0);
      expect(customer.currentDebt, 0.0);
      expect(customer.availableCredit, 300.0);
    });

    test('deve falhar ao cadastrar cliente com nome vazio ou somente espaços', () {
      expect(
        () => Customer(
          id: 'cust-2',
          name: '   ',
          phone: '11987654321',
          creditLimit: 200.0,
        ),
        throwsA(isA<InvalidCustomerDataFailure>()),
      );
    });

    test('deve falhar ao cadastrar cliente com limite de crédito menor ou igual a zero', () {
      expect(
        () => Customer(
          id: 'cust-3',
          name: 'Seu Zé do Bar',
          phone: '11987654321',
          creditLimit: 0.0,
        ),
        throwsA(isA<InvalidCustomerDataFailure>()),
      );

      expect(
        () => Customer(
          id: 'cust-4',
          name: 'Seu Zé do Bar',
          phone: '11987654321',
          creditLimit: -50.0,
        ),
        throwsA(isA<InvalidCustomerDataFailure>()),
      );
    });
  });
}
