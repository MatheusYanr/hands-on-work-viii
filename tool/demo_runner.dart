import 'package:caderneta_digital_fiado/core/errors/failures.dart';
import 'package:caderneta_digital_fiado/domain/entities/customer.dart';
import 'package:caderneta_digital_fiado/domain/entities/credit_transaction.dart';
import 'package:caderneta_digital_fiado/domain/repositories/customer_repository.dart';
import 'package:caderneta_digital_fiado/domain/usecases/register_customer.dart';
import 'package:caderneta_digital_fiado/domain/usecases/record_purchase.dart';

/// Dublê local para demonstração do Tech Lead (Arthur) antes da camada de dados do Matheus
class _DemoMockRepository implements CustomerRepository {
  final Map<String, Customer> _db = {};
  final List<CreditTransaction> _txs = [];

  @override
  Future<Customer> saveCustomer(Customer c) async {
    _db[c.id] = c;
    return c;
  }

  @override
  Future<Customer?> getCustomerById(String id) async => _db[id];

  @override
  Future<List<Customer>> getAllCustomers() async => _db.values.toList();

  @override
  Future<Customer> updateCustomer(Customer c) async {
    _db[c.id] = c;
    return c;
  }

  @override
  Future<CreditTransaction> saveTransaction(CreditTransaction t) async {
    _txs.add(t);
    return t;
  }

  @override
  Future<List<CreditTransaction>> getTransactionsByCustomer(String id) async =>
      _txs.where((t) => t.customerId == id).toList();
}

void main() async {
  print('===============================================================');
  print('📓 CADERNETA DIGITAL DE FIADO — ESCOPO DO TECH LEAD (ARTHUR)');
  print('Demonstração da Arquitetura Limpa, TDD e 1ª Funcionalidade Financeira');
  print('===============================================================\n');

  final repository = _DemoMockRepository();
  final registerCustomer = RegisterCustomer(repository);
  final recordPurchase = RecordPurchase(repository);

  // -------------------------------------------------------------------------
  // 1. CADASTRO DE CLIENTE
  // -------------------------------------------------------------------------
  print('🔵 [ENTREGA ARTHUR: REGRA 1] Cadastrando cliente com limite aprovado:');
  final cliente = await registerCustomer(
    id: 'cli-001',
    name: 'Dona Maria da Silva',
    phone: '(11) 98765-4321',
    creditLimit: 300.0,
  );

  print('   ✅ Cliente: ${cliente.name}');
  print('   ✅ Limite de Crédito: R\$ ${cliente.creditLimit.toStringAsFixed(2)}');
  print('   ✅ Saldo Devedor Inicial: R\$ ${cliente.currentDebt.toStringAsFixed(2)} (Obrigatório 0.0)');
  print('   ✅ Crédito Disponível: R\$ ${cliente.availableCredit.toStringAsFixed(2)}\n');

  // -------------------------------------------------------------------------
  // 2. REGISTRAR COMPRA FIADA (SOMA AO SALDO)
  // -------------------------------------------------------------------------
  print('🔵 [ENTREGA ARTHUR: REGRA 2] Registrando compras a prazo:');
  print('   🛒 Compra 1: 5kg Arroz, Feijão e Óleo -> R\$ 85,50');
  final compra1 = await recordPurchase(
    customerId: cliente.id,
    amount: 85.50,
    description: 'Arroz, Feijão e Óleo',
  );
  print('      -> Saldo Devedor: R\$ ${compra1.customer.currentDebt.toStringAsFixed(2)}');
  print('      -> Limite Restante: R\$ ${compra1.customer.availableCredit.toStringAsFixed(2)}');

  print('   🛒 Compra 2: Carnes e Frios da semana -> R\$ 150,00');
  final compra2 = await recordPurchase(
    customerId: cliente.id,
    amount: 150.00,
    description: 'Carnes e Frios',
  );
  print('      -> Saldo Devedor: R\$ ${compra2.customer.currentDebt.toStringAsFixed(2)}');
  print('      -> Limite Restante: R\$ ${compra2.customer.availableCredit.toStringAsFixed(2)}\n');

  // -------------------------------------------------------------------------
  // 3. TRAVA AUTOMÁTICA DE LIMITE DE CRÉDITO
  // -------------------------------------------------------------------------
  print('🔴 [ENTREGA ARTHUR: TESTE DE TRAVA] Tentativa de compra acima do teto de fiado:');
  print('   🛒 Compra 3: R\$ 100,00 (Total seria R\$ 335,50 > Limite R\$ 300,00)');
  try {
    await recordPurchase(
      customerId: cliente.id,
      amount: 100.00,
      description: 'Cesta Básica Premium',
    );
    print('   ❌ ERRO: A compra não deveria ter passado!');
  } on CreditLimitExceededFailure catch (e) {
    print('   🛡️ BLOQUEIO AUTOMÁTICO DISPARADO COM SUCESSO!');
    print('      Motivo: $e\n');
  }

  print('===============================================================');
  print('✅ PARTE DO ARTHUR (TECH LEAD): ARQUITETURA, CI E 1ª FUNCIONALIDADE');
  print('👉 PRÓXIMO PASSO (MATHEUS): Implementar Camada de Dados e 2ª Funcionalidade');
  print('===============================================================');
}
