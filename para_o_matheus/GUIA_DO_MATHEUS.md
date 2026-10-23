# 📋 Guia de Entrega da Parte Técnica — Para o Matheus
### *De: Arthur (Tech Lead) | Para: Matheus (Segundo Dev)*

Fala Matheus, beleza?

Cara, criei este guia rápido para te orientar e facilitar 100% a sua entrega do nosso trabalho prático (**HOW VIII**).

Como combinamos na nossa divisão de papéis:
* **O que eu já fiz:** Subi o repositório oficial no GitHub com a Clean Architecture montada, a esteira de CI/CD automática rodando no GitHub Actions e implementei a 1ª funcionalidade financeira com TDD (cadastro de cliente e registro de compras com trava automática de limite). Também já deixei escritas as minhas seções do relatório (4.1.6 e 4.1.7) e o roteiro do vídeo.
* **O que cabe a você fazer agora:** A **Camada de Dados**, a **Segunda Funcionalidade** com testes unitários, e a escrita da **Seção 4.1.5** no relatório.

Abaixo deixei tudo mastigado para você codificar e comitar com a sua conta no Git sem estresse.

---

## 📌 As Suas Duas Entregas:

### 1. No Relatório Escrito (Word):
Você precisa redigir a **Seção 4.1.5 Atividades e Tarefas**:
* Descreva o cronograma do nosso grupo, como dividimos as tarefas e as ferramentas que usamos para nos comunicar.
* Mencione que eu atuei na arquitetura, CI e 1ª funcionalidade, e você como segundo desenvolvedor implementando a camada de dados e a segunda funcionalidade com testes.

### 2. No Código (GitHub):
Você tem duas coisas para subir no repositório:

#### 🔹 Tarefa A: Segunda Funcionalidade Financeira com TDD (Baixa de Pagamento)
Você vai implementar o caso de uso de **Baixa de Pagamento / Amortização de Fiado**:
* **Regra:** O cliente vem pagar a conta. O valor tem que ser positivo e você **não pode permitir** que o pagamento seja maior que a dívida atual (para não gerar saldo negativo).
* **Onde criar os arquivos:**
  * O teste unitário: `test/domain/usecases/process_payment_test.dart`
  * A implementação: `lib/domain/usecases/process_payment.dart`
* *(Dica: deixei os arquivos de modelo prontos aqui nesta mesma pasta caso você queira conferir a lógica matemática!)*

#### 🔹 Tarefa B: Camada de Dados (`lib/data/`)
Você vai implementar a persistência de dados conectando com o contrato que eu deixei pronto em `lib/domain/repositories/customer_repository.dart`:
* **Onde criar:** Crie a pasta `lib/data/repositories/` e o arquivo `in_memory_customer_repository.dart` (ou a persistência local que preferir).
* *(Dica: o código de referência também já está salvo aqui nesta pasta para te ajudar).*

---

## 🚀 Passo a Passo dos Comandos Git que Você Deve Rodar no Terminal

Para o professor ver os seus commits registrados no GitHub com o seu nome, siga este passo a passo:

```bash
# 1. Clone o repositório na sua máquina
git clone https://github.com/arthurliszkievich/hands-on-work-viii.git
cd hands-on-work-viii

# 2. Configure o seu nome e email no Git (caso ainda não tenha feito)
git config user.name "Seu Nome Completo"
git config user.email "seu_email@exemplo.com"

# 3. Baixe as dependências do Flutter
flutter pub get

# 4. [PASSO RED DO TDD] Adicione primeiro o arquivo de teste unitário
# Coloque o arquivo process_payment_test.dart dentro de test/domain/usecases/
git add test/domain/usecases/process_payment_test.dart
git commit -m "test(payment): [RED] add unit tests for processing payment and debt reduction"

# 5. [PASSO GREEN DO TDD] Adicione a implementação do caso de uso
# Coloque o arquivo process_payment.dart dentro de lib/domain/usecases/
git add lib/domain/usecases/process_payment.dart
git commit -m "feat(payment): [GREEN] implement process_payment use case with debt deduction"

# 6. Adicione a Camada de Dados
# Coloque o in_memory_customer_repository.dart dentro de lib/data/repositories/
git add lib/data/repositories/
git commit -m "feat(data): implement in-memory customer repository for data persistence"

# 7. Rode os testes para ver se tudo ficou verde
flutter test

# 8. Suba as suas alterações para o GitHub
git push origin main
```

---

Qualquer dúvida ou se você travar em alguma parte do código, me dá um toque no WhatsApp que a gente resolve junto! Tamo junto!
