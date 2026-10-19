# Roteiro de Gravação — Parte Técnica (Duração Exata: 1 Minuto)

> **Contexto:** Vídeo final de apresentação do trabalho prático (HOW VIII). O tempo total do grupo é de 3 minutos, cabendo a você exatamente **1 minuto** (60 segundos) para demonstrar a excelência técnica, a metodologia TDD (Test-Driven Development) e a pipeline de CI/CD.
> **Tom:** Profissional, enérgico, seguro e objetivo de Tech Lead.

---

## Tabela de Gravação Segundo a Segundo (1:00)

| Tempo | O QUE VOCÊ DEVE MOSTRAR NA TELA | O QUE VOCÊ DEVE FALAR (ÁUDIO) |
| :--- | :--- | :--- |
| **0:00 - 0:15** <br>*(15 seg)* | **Terminal aberto com o comando:**<br>`git log --oneline --graph -n 10`<br>*(Destacando os commits com as tags `[RED]`, `[GREEN]` e `[REFACTOR]`)* | "Olá! Como Tech Lead da Caderneta Digital de Fiado, priorizei a máxima confiabilidade técnica adotando estritamente o TDD. Como vocês podem ver no histórico do nosso Git, cada regra financeira seguiu o ciclo Red, Green e Refactor, garantindo que os testes fossem criados antes de qualquer linha de código de produção." |
| **0:15 - 0:32** <br>*(17 seg)* | **IDE / VS Code:**<br>Mostrando lado a lado o teste unitário (`record_purchase_test.dart`) e a regra de negócio (`record_purchase.dart`).<br>Em seguida, executa no terminal:<br>`flutter test --coverage` | "Isolamos as regras de negócio em Clean Architecture. Cobrimos três cenários críticos do comerciante: cadastro com dívida zero, registro de compra fiada com trava automática de limite de crédito e amortização de pagamento sem permitir saldo negativo. Rodando a suíte de testes agora, vemos 100% de sucesso!" |
| **0:32 - 0:48** <br>*(16 seg)* | **Navegador web aberto na aba "Actions" do GitHub:**<br>Exibindo a pipeline do GitHub Actions com o check verde ✅ *(Run Analysis & Unit Tests)* e o log do `flutter test`. | "Para garantir que nada quebre em produção, configuramos uma esteira de Integração Contínua com GitHub Actions. A cada push, a pipeline executa a análise estática e roda toda a nossa bateria de testes unitários com extração de cobertura LCOV de forma 100% automatizada." |
| **0:48 - 1:00** <br>*(12 seg)* | **Emulador do Flutter ou Tela Inicial do App:**<br>Exibindo o aplicativo rodando de forma limpa e os cards de clientes com saldo e limite disponível. | "Com isso, entregamos um aplicativo blindado contra falhas matemáticas, substituindo o caderno de papel por uma solução auditável e segura para o pequeno empreendedor. Passo a palavra para o próximo colega!" |

---

## Dicas Práticas de Gravação para o Arthur:
1. **Prepare as abas antes de gravar:**
   - Aba 1: Terminal limpo na pasta do projeto com fonte grande (Ctrl + Shift + +).
   - Aba 2: VS Code com fonte nítida dividida em duas colunas (`record_purchase_test.dart` e `record_purchase.dart`).
   - Aba 3: Navegador aberto no GitHub do repositório: `https://github.com/arthurliszkievich/hands-on-work-viii/actions`.
2. **Treino de fala:** Leia o roteiro em voz alta 2 vezes com um cronômetro no celular para calibrar a respiração e a dicção dentro dos 60 segundos exatos.
