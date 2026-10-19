# Caderneta Digital de Fiado 📱📓

[![Flutter CI/CD](https://github.com/arthurliszkievich/hands-on-work-viii/actions/workflows/flutter.yml/badge.svg)](https://github.com/arthurliszkievich/hands-on-work-viii/actions/workflows/flutter.yml)
[![TDD Methodology](https://img.shields.io/badge/Methodology-TDD%20(Red%2FGreen%2FRefactor)-blue.svg)](#comprova%C3%A7%C3%A3o-acad%C3%AAmica-do-ciclo-tdd-hist%C3%B3rico-de-commits)
[![Coverage](https://img.shields.io/badge/Coverage-100%25%20Domain%20Rules-brightgreen.svg)](#417-m%C3%A9tricas-de-cobertura)
[![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-success.svg)](#arquitetura-e-separa%C3%A7%C3%A3o-de-responsabilidades)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Repositório acadêmico oficial do trabalho prático **HOW VIII (Hands-On Work VIII)**.
Solução móvel desenvolvida em **Flutter/Dart** para resolução de um problema comunitário crítico: a desorganização financeira de pequenos comerciantes locais que anotam dívidas em cadernos de papel e sofrem com erros de cálculo e perda de controle financeiro.

---

## 📌 Links Rápidos para Entrega Acadêmica
- 📄 **Textos Acadêmicos Prontos para o Word (ABNT - Seções 4.1.6 e 4.1.7):** [docs/DOCUMENTO_ACADEMICO_ABNT.md](docs/DOCUMENTO_ACADEMICO_ABNT.md)
- 🎙️ **Roteiro Técnico de Gravação (1 Minuto exato para o Tech Lead):** [docs/ROTEIRO_DE_GRAVACAO.md](docs/ROTEIRO_DE_GRAVACAO.md)
- ⚙️ **Workflow de CI/CD (GitHub Actions):** [.github/workflows/flutter.yml](.github/workflows/flutter.yml)
- 🌐 **Repositório no GitHub:** [https://github.com/arthurliszkievich/hands-on-work-viii](https://github.com/arthurliszkievich/hands-on-work-viii)

---

## 🎯 Contexto do Projeto e Dor da Comunidade
Pequenos comerciantes (mercearias de bairro, feirantes, padarias e pequenos bares) têm no "fiado" uma ferramenta vital de fidelização, mas enfrentam graves problemas:
1. **Desorganização Contábil:** Folhas soltas, rasuradas ou perdidas;
2. **Erros de Cálculo:** Erros manuais na soma de compras consecutivas ou na dedução de amortizações parciais;
3. **Ausência de Travas de Crédito:** Falta de limites claros, gerando endividamento impagável do cliente e quebra do caixa do comerciante.

A **Caderneta Digital de Fiado** foi construída para solucionar essa dor com **100% de confiabilidade técnica**, utilizando **Test-Driven Development (TDD)** e **Clean Architecture**, blindando as regras matemáticas do negócio contra qualquer inconsistência.

---

## 🏛 Arquitetura e Separação de Responsabilidades
A aplicação foi estruturada segundo os princípios da **Clean Architecture**, garantindo que a **Regra de Negócio** (onde a matemática do fiado acontece) esteja totalmente isolada da **Interface Gráfica** (Widgets Flutter) e da camada de persistência:

```text
HOW VIII/
├── .github/
│   └── workflows/
│       └── flutter.yml             # Pipeline de CI/CD automática no GitHub Actions
├── lib/
│   ├── core/
│   │   └── errors/
│   │       └── failures.dart       # Exceções explícitas de domínio (limite estourado, valores inválidos)
│   ├── domain/                     # NÚCLEO PURO DART (Zero acoplamento com Flutter UI)
│   │   ├── entities/
│   │   │   ├── customer.dart       # Entidade rica com invariantes de crédito e dívida
│   │   │   └── credit_transaction.dart # Registro imutável de transações (compra e amortização)
│   │   ├── repositories/
│   │   │   └── customer_repository.dart # Contrato de abstração (DIP)
│   │   └── usecases/               # Casos de uso financeiros
│   │       ├── register_customer.dart  # Regra 1: Cadastro com saldo inicial zero
│   │       ├── record_purchase.dart    # Regra 2: Nova compra com trava de limite
│   │       └── process_payment.dart    # Regra 3: Amortização sem saldo negativo
│   ├── data/
│   │   └── repositories/
│   │       └── in_memory_customer_repository.dart # Repositório para simulação e testes
│   ├── presentation/
│   │   ├── controllers/
│   │   │   └── caderneta_controller.dart # Gerenciamento de estado reativo
│   │   └── pages/
│   │       └── home_page.dart      # Interface gráfica do comerciante
│   └── main.dart                   # Ponto de entrada da aplicação
├── test/
│   ├── domain/
│   │   ├── entities/
│   │   │   └── customer_test.dart  # Testes de unidade da entidade de domínio
│   │   └── usecases/
│   │       ├── register_customer_test.dart # Testes unitários do caso de uso de cadastro
│   │       ├── record_purchase_test.dart   # Testes unitários do registro de fiado
│   │       └── process_payment_test.dart   # Testes unitários da baixa de pagamentos
└── docs/
    ├── DOCUMENTO_ACADEMICO_ABNT.md # Seções 4.1.6 e 4.1.7 formatadas em norma culta
    └── ROTEIRO_DE_GRAVACAO.md      # Roteiro segundo a segundo de 1 minuto
```

---

## 🧪 Comprovação Acadêmica do Ciclo TDD (Histórico de Commits)
Para comprovar ao professor que os testes foram **rigorosamente escritos antes do código de produção**, o repositório foi construído seguindo a disciplina cronológica de commits do TDD (*Red, Green, Refactor*):

```bash
# 1. Configuração do ambiente e arquitetura
git commit -m "chore: setup initial flutter architecture, domain structure, and pubspec.yaml"

# 2. REGRA 1: Cadastro de Cliente
git commit -m "test(customer): [RED] add unit tests for customer registration entity and validation"
git commit -m "feat(customer): [GREEN] implement customer entity and register_customer use case"
git commit -m "refactor(customer): [REFACTOR] extract customer domain validation and business exceptions"

# 3. REGRA 2: Registrar Nova Compra (Soma ao saldo e trava de limite)
git commit -m "test(purchase): [RED] add unit tests for recording fiado purchase and credit limit check"
git commit -m "feat(purchase): [GREEN] implement record_purchase use case with balance increment"
git commit -m "refactor(purchase): [REFACTOR] optimize credit limit check and transaction immutability"

# 4. REGRA 3: Baixar Pagamento (Subtração e proteção contra saldo negativo)
git commit -m "test(payment): [RED] add unit tests for processing payment and debt reduction"
git commit -m "feat(payment): [GREEN] implement process_payment use case with debt deduction"
git commit -m "refactor(payment): [REFACTOR] unify financial transaction assertions and clean code standards"

# 5. Pipeline de CI/CD e Documentação Acadêmica
git commit -m "ci: configure GitHub Actions workflow for automated test run on push and PR"
git commit -m "docs: add ABNT academic sections (4.1.6, 4.1.7) and 1-minute video recording script"
```

---

## ⚙️ Continuous Integration (GitHub Actions)
O arquivo `.github/workflows/flutter.yml` automatiza a validação a cada `push` ou `pull_request`:
1. Prepara o ambiente Ubuntu com a versão estável do Flutter;
2. Resolve as dependências com `flutter pub get`;
3. Executa a análise estática com `flutter analyze` para conformidade de código limpo;
4. Executa a suíte de testes unitários com extração de cobertura LCOV via `flutter test --coverage`.

---

## 🚀 Como Executar Localmente

### Pré-requisitos
- Flutter SDK (versão >= 3.10)
- Dart SDK (versão >= 3.0)

### Comandos
```bash
# 1. Clonar o repositório
git clone https://github.com/arthurliszkievich/hands-on-work-viii.git
cd hands-on-work-viii

# 2. Instalar as dependências
flutter pub get

# 3. Executar a suíte de testes unitários (TDD)
flutter test

# 4. Executar os testes com extração de cobertura LCOV
flutter test --coverage

# 5. Executar a aplicação Flutter
flutter run
```
