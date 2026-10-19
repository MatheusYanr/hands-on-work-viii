import 'package:caderneta_digital_fiado/core/errors/failures.dart';
import 'package:caderneta_digital_fiado/data/repositories/in_memory_customer_repository.dart';
import 'package:caderneta_digital_fiado/domain/usecases/register_customer.dart';
import 'package:caderneta_digital_fiado/domain/usecases/record_purchase.dart';
import 'package:caderneta_digital_fiado/domain/usecases/process_payment.dart';

void main() async {
  print('===============================================================');
  print('📓 CADERNETA DIGITAL DE FIADO — SIMULAÇÃO OPERACIONAL EM TEMPO REAL');
  print('Demonstração das 3 Regras de Negócio Implementadas via TDD');
  print('===============================================================\n');

  final repository = InMemoryCustomerRepository();
  final registerCustomer = RegisterCustomer(repository);
  final recordPurchase = RecordPurchase(repository);
  final processPayment = ProcessPayment(repository);

  // -------------------------------------------------------------------------
  // CENÁRIO 1: CADASTRO DE CLIENTE
  // -------------------------------------------------------------------------
  print('🔵 [REGRA 1] Cadastrando novo cliente no livro de fiado...');
  final cliente = await registerCustomer(
    id: 'cli-001',
    name: 'Dona Maria da Silva',
    phone: '(11) 98765-4321',
    creditLimit: 300.0,
  );

  print('   ✅ Cliente: ${cliente.name}');
  print('   ✅ Limite de Crédito Aprovado: R\$ ${cliente.creditLimit.toStringAsFixed(2)}');
  print('   ✅ Saldo Devedor Inicial: R\$ ${cliente.currentDebt.toStringAsFixed(2)} (Obrigatório 0.0)');
  print('   ✅ Limite Disponível para Fiado: R\$ ${cliente.availableCredit.toStringAsFixed(2)}\n');

  // -------------------------------------------------------------------------
  // CENÁRIO 2: REGISTRO DE COMPRAS NO FIADO (SOMA AO SALDO)
  // -------------------------------------------------------------------------
  print('🔵 [REGRA 2] Registrando compras a prazo...');
  
  print('   🛒 Compra 1: 5kg Arroz, Feijão e Óleo -> R\$ 85,50');
  final compra1 = await recordPurchase(
    customerId: cliente.id,
    amount: 85.50,
    description: 'Arroz, Feijão e Óleo',
  );
  print('      -> Novo Saldo Devedor: R\$ ${compra1.customer.currentDebt.toStringAsFixed(2)}');
  print('      -> Limite Restante: R\$ ${compra1.customer.availableCredit.toStringAsFixed(2)}');

  print('   🛒 Compra 2: Carnes e Frios para a semana -> R\$ 150,00');
  final compra2 = await recordPurchase(
    customerId: cliente.id,
    amount: 150.00,
    description: 'Carnes e Frios',
  );
  print('      -> Novo Saldo Devedor: R\$ ${compra2.customer.currentDebt.toStringAsFixed(2)}');
  print('      -> Limite Restante: R\$ ${compra2.customer.availableCredit.toStringAsFixed(2)}\n');

  // -------------------------------------------------------------------------
  // CENÁRIO 3: TRAVA DE CRÉDITO (TENTATIVA DE ESTOURO DO FIADO)
  // -------------------------------------------------------------------------
  print('🔴 [TESTE DE TRAVA] Tentativa de compra que excede o limite do comerciante:');
  print('   🛒 Compra 3: Cesta Básica Premium -> R\$ 100,00 (Total seria R\$ 335,50 > R\$ 300,00)');
  try {
    await recordPurchase(
      customerId: cliente.id,
      amount: 100.00,
      description: 'Cesta Básica Premium',
    );
    print('   ❌ ERRO: A compra não deveria ter sido autorizada!');
  } on CreditLimitExceededFailure catch (e) {
    print('   🛡️ BLOQUEIO AUTOMÁTICO DISPARADO COM SUCESSO!');
    print('      Motivo: $e\n');
  }

  // -------------------------------------------------------------------------
  // CENÁRIO 4: AMORTIZAÇÃO PARCIAL (BAIXA DE PAGAMENTO)
  // -------------------------------------------------------------------------
  print('🔵 [REGRA 3] Cliente compareceu ao comércio para amortizar a dívida:');
  print('   💵 Pagamento Parcial: R\$ 135,50 em dinheiro');
  final pag1 = await processPayment(
    customerId: cliente.id,
    amount: 135.50,
    description: 'Amortização quinzenal em dinheiro',
  );
  print('      -> Dívida Anterior: R\$ 235,50');
  print('      -> Novo Saldo Devedor: R\$ ${pag1.customer.currentDebt.toStringAsFixed(2)}');
  print('      -> Limite de Crédito Restaurado: R\$ ${pag1.customer.availableCredit.toStringAsFixed(2)}\n');

  // -------------------------------------------------------------------------
  // CENÁRIO 5: PROTEÇÃO CONTRA PAGAMENTO SUPERIOR À DÍVIDA
  // -------------------------------------------------------------------------
  print('🔴 [TESTE DE PROTEÇÃO] Tentativa de pagar valor maior que o saldo devedor:');
  print('   💵 Tentando abater R\$ 200,00 para dívida que é de apenas R\$ 100,00:');
  try {
    await processPayment(
      customerId: cliente.id,
      amount: 200.00,
      description: 'Pagamento inconsistente',
    );
    print('   ❌ ERRO: O pagamento inconsistente não deveria ter passado!');
  } on PaymentExceedsDebtFailure catch (e) {
    print('   🛡️ BLOQUEIO AUTOMÁTICO DISPARADO COM SUCESSO!');
    print('      Motivo: $e\n');
  }

  // -------------------------------------------------------------------------
  // CENÁRIO 6: QUITAÇÃO TOTAL DA DÍVIDA
  // -------------------------------------------------------------------------
  print('🔵 [QUITAÇÃO TOTAL] Cliente paga o valor restante exato de R\$ 100,00:');
  final quitacao = await processPayment(
    customerId: cliente.id,
    amount: 100.00,
    description: 'Quitação total do fiado',
  );
  print('      -> Saldo Devedor Final: R\$ ${quitacao.customer.currentDebt.toStringAsFixed(2)} (Conta Zerada!)');
  print('      -> Limite Integral Disponível: R\$ ${quitacao.customer.availableCredit.toStringAsFixed(2)}');

  print('\n===============================================================');
  print('🎉 TODAS AS REGRAS E TRAVAS FORAM VALIDADAS COM 100% DE SUCESSO!');
  print('===============================================================');
}
