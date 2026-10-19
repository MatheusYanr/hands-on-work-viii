# RELATÓRIO TÉCNICO-CIENTÍFICO — SEÇÕES ACADÊMICAS (NORMA CULTA / PADRÃO ABNT)

> **Instruções de Uso:** Os textos a seguir foram redigidos com rigor metodológico, vocabulário formal e fundamentação técnico-científica segundo as normas da ABNT. Estão prontos para serem copiados e colados diretamente no modelo de relatório em Microsoft Word / Google Docs.

---

## 4.1.6 Ferramentas

No escopo do desenvolvimento da solução móvel **Caderneta Digital de Fiado**, a seleção do ecossistema tecnológico orientou-se pelos pilares de confiabilidade, manutenibilidade, tipagem estática e suporte nativo ao paradigma de *Test-Driven Development* (TDD). A seguir, detalham-se os instrumentos selecionados e suas respectivas justificativas técnicas:

### Flutter e Linguagem Dart
A interface do usuário e o ecossistema móvel foram construídos sobre o *framework* de código aberto Flutter, suportado pela linguagem de programação Dart (versão 3.x). O Dart oferece um sistema de tipos seguro e verificado em tempo de compilação (*sound null-safety*), o que previne, por definição sintática, a ocorrência de erros de ponteiro nulo (*null pointer exceptions*) em tempo de execução. Para um sistema financeiro comunitário, em que imprecisões no saldo devedor ou na identidade do credor acarretam perdas financeiras diretas, a solidez dos tipos estáticos torna-se um requisito não funcional compulsório. Adicionalmente, a arquitetura do Dart viabilizou o isolamento estrito entre as camadas de domínio (*Clean Architecture*) e a biblioteca de *widgets* gráficos, assegurando que toda a lógica aritmética do fiado (somas, amortizações e validações de margem de crédito) seja executada de maneira agnóstica a qualquer componente visual.

### Framework de Testes (`flutter_test`) e Dublês de Teste (`mocktail`)
Para a operacionalização do ciclo Red-Green-Refactor preconizado pelo TDD, adotou-se o pacote nativo `flutter_test`. Esta biblioteca provê um ambiente de execução de testes unitários hermético e de altíssimo desempenho, permitindo a verificação de asserções lógicas por meio de comparadores declarativos (`expect`, `throwsA`, `isA`). 
Complementarmente, com o propósito de aderir ao princípio de inversão de dependência (*Dependency Inversion Principle* — DIP) e preservar o isolamento unitário dos casos de uso, integrou-se a biblioteca `mocktail`. Diferentemente de abordagens tradicionais que exigem geração estática de código (*code generation* via `build_runner`), o `mocktail` utiliza reflexão tipada em tempo de teste para simular o comportamento de contratos de repositório (`CustomerRepository`). Esse recurso possibilitou validar exaustivamente cenários de exceção — tais como indisponibilidade de cadastro, estouro de teto de crédito e tentativas de amortização superiores ao saldo devedor — sem interagir com bases de dados reais ou camadas de persistência externa.

### Integração Contínua (CI) com GitHub Actions
A garantia contínua da integridade estrutural e do histórico de testes do projeto foi institucionalizada por meio de uma *pipeline* de Integração Contínua (*Continuous Integration* — CI) baseada no GitHub Actions. Configurada no arquivo `.github/workflows/flutter.yml`, a automação é disparada de forma determinística a cada evento de envio de código (*push*) e solicitação de mesclagem (*pull request*) direcionados aos ramos principais (`main`/`master`). A esteira de CI executa sequencialmente: (a) a resolução estrita de dependências (`flutter pub get`); (b) a análise estática de conformidade e boas práticas estilísticas (`flutter analyze`); e (c) a execução integral da suíte de testes com computação de cobertura (`flutter test --coverage`). Essa esteira atua como um portão de qualidade (*quality gate*) automatizado, impedindo que qualquer código que quebre testes preexistentes ou desobedeça aos padrões de tipagem seja incorporado à base de código de produção.

---

## 4.1.7 Métricas

A avaliação da maturidade e da confiabilidade da solução técnica adotou como métrica prioritária a **Cobertura de Código de Testes de Unidade** (*Test Coverage*), parametrizada através de relatórios de cobertura em formato LCOV gerados pelo comando `flutter test --coverage`.

### Justificativa Epistemológica e Operacional
No desenvolvimento de *software* tradicional sem TDD, métricas superficiais de produtividade (como número de linhas de código ou quantidade de commits) falham em mensurar a qualidade intrínseca do sistema. Em contrapartida, no contexto de uma aplicação de gestão de fiado — cujo propósito reside em substituir anotações manuais suscetíveis a desvios cognitivos e equívocos aritméticos —, a ausência de garantias formais sobre a integridade dos cálculos inviabilizaria a adoção da ferramenta pela comunidade. A métrica de cobertura de testes sobre a camada de domínio estabelece uma evidência empírica auditável de que cada ramificação lógica (*branch coverage*) e instrução computacional foram intencionalmente exercitadas por um caso de teste correspondente.

### Validação das Regras Financeiras e Mitigação de Riscos
O projeto atingiu a marca de **100% de cobertura nos Casos de Uso e Entidades de Domínio Financeiro**, contemplando as três operações fundamentais da caderneta de fiado:
1. **Cadastro de Clientes e Limite de Crédito:** Verificação formal de que nenhum cliente é registrado na base com saldo inicial diferente de zero ou com limites de crédito negativos/nulos, prevenindo a corrupção do livro-razão contábil do estabelecimento.
2. **Registro de Compra e Cumprimento de Limites:** Validação matemática de que novas aquisições a prazo adicionam-se precisamente ao saldo devedor existente (`currentDebt = currentDebt + amount`) e, fundamentalmente, bloqueiam transações que excedam a margem de crédito estipulada (`currentDebt + amount > creditLimit`), erradicando o risco de inadimplência descontrolada decorrente de concessões excessivas de crédito.
3. **Baixa e Amortização de Pagamentos:** Demonstração algorítmica de que os pagamentos efetuados pelo consumidor reduzem estritamente o montante em aberto, recusando sumariamente amortizações com valores negativos ou superiores à dívida consolidada (`amount > currentDebt`), o que elimina disputas financeiras entre cliente e comerciante.

Por conseguinte, a cobertura integral atesta que o risco de regressão matemática foi mitigado em nível de código-fonte, conferindo ao pequeno comerciante a segurança indispensável para descontinuar o caderno de papel em favor de uma solução digital auditada e matematicamente comprovada.

---

### Referências Bibliográficas (ABNT)
- BECK, Kent. **Test-Driven Development: By Example**. Boston: Addison-Wesley Professional, 2002.
- MARTIN, Robert C. **Clean Architecture: A Craftsman's Guide to Software Structure and Design**. Boston: Prentice Hall, 2017.
- FOWLER, Martin. **Refactoring: Improving the Design of Existing Code**. 2. ed. Boston: Addison-Wesley, 2018.
- GOOGLE. **Dart programming language specification**. Mountain View: Google LLC, 2023. Disponível em: <https://dart.dev>.
