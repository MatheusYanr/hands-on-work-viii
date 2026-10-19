# Caderneta Digital de Fiado 📱📓

[![Flutter CI/CD](https://github.com/arthurliszkievich/hands-on-work-viii/actions/workflows/flutter.yml/badge.svg)](https://github.com/arthurliszkievich/hands-on-work-viii/actions/workflows/flutter.yml)
[![TDD - Test Driven Development](https://img.shields.io/badge/Methodology-TDD%20(Red%2FGreen%2FRefactor)-blue.svg)](#metodologia-tdd)
[![Coverage](https://img.shields.io/badge/Coverage-100%25%20Domain-brightgreen.svg)](#m%C3%A9tricas-e-cobertura)
[![Clean Architecture](https://img.shields.io/badge/Architecture-Clean%20Architecture-success.svg)](#arquitetura-e-separa%C3%A7%C3%A3o-de-responsabilidades)

Repositório acadêmico oficial do trabalho prático **HOW VIII (Hands-On Work VIII)**.
Solução móvel desenvolvida em **Flutter/Dart** para resolução da dor comunitária de pequenos comerciantes: a desorganização financeira decorrente de anotações manuais de crédito/fiado em cadernos de papel.

---

## 🎯 Objetivo e Contexto
Pequenos comerciantes (como donos de mercearias, padarias e feirantes) frequentemente utilizam cadernos físicos para registrar o "fiado". Essa prática arcaica acarreta:
- Perda de controle contábil e esquecimento de cobranças;
- Erros matemáticos de soma em novas compras e subtração em pagamentos parciais;
- Ausência de travas de limite de crédito pré-estipulado, gerando endividamento impagável do cliente e insolvência do comerciante.

A **Caderneta Digital de Fiado** soluciona esse problema por meio de uma aplicação móvel confiável, construída estritamente sob **Test-Driven Development (TDD)** e **Clean Architecture**, blindando 100% da matemática e regras de negócio contra falhas humanas ou técnicas.

---

## 🏛 Arquitetura e Separação de Responsabilidades
Para isolar a regra de negócio da interface gráfica (garantindo que cálculos e limites funcionem independentemente de frameworks ou telas), adotou-se o padrão **Clean Architecture**:

```text
lib/
├── core/
│   └── errors/                  # Exceções e falhas do domínio financeiro
├── domain/                      # NÚCLEO PURO (Sem dependência de Flutter UI)
│   ├── entities/                # Customer, CreditTransaction
│   ├── repositories/            # Contratos abstratos de persistência
│   └── usecases/                # Casos de uso financeiros (Cadastro, Compra, Pagamento)
├── data/                        # IMPLEMENTAÇÃO DE DADOS
│   └── repositories/            # Implementação concreta (In-Memory / Local Cache)
└── presentation/                # CAMADA DE INTERFACE
    ├── controllers/             # Gerenciamento de estado da caderneta
    └── pages/                   # Telas interativas (Mobile UI)
```

---

## 🧪 Metodologia TDD (Ciclo Red-Green-Refactor)
O projeto seguiu rigorosamente os 3 passos do ciclo de Kent Beck para cada regra de negócio:
1. **RED:** Escrita antecipada de testes unitários que falham por ausência de implementação.
2. **GREEN:** Implementação do código mínimo indispensável para que todos os testes passem com sucesso.
3. **REFACTOR:** Limpeza e aprimoramento da arquitetura sem alterar o comportamento validado pelos testes.

---

## 🛠 Tecnologias e Ferramentas
- **Linguagem & Framework:** Dart 3.x / Flutter 3.x
- **Testes Unitários & Dublês:** `flutter_test`, `mocktail`
- **Integração Contínua (CI):** GitHub Actions (`.github/workflows/flutter.yml`)
- **Padrões:** Clean Architecture, Domain-Driven Design (DDD) tático, Imutabilidade
