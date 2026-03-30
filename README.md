# Estudo Dirigido — Parte 1: Modelagem de Sinais e Sistemas Discretos

**Disciplina:** Processamento Digital de Sinais (PDS)  
**Curso:** Engenharia da Computação
**Instituição:** Instituto Federal da Paraíba — IFPB  
**Semestre:** 2026.1

---

## Objetivo

Este repositório contém a entrega completa da Parte 1 do Estudo Dirigido de PDS, cujo objetivo é introduzir os fundamentos matemáticos da representação e análise de sinais discretos, bem como a modelagem e classificação de sistemas digitais.

**Problema Norteador (PBL):** *Como representar matematicamente o comportamento temporal de um sensor real e quais propriedades estruturais devem ser analisadas para garantir o correto processamento digital desse sinal?*

---

## Estrutura do Repositório

```
PDS/
├── teoria/
│   ├── resumo_teorico.md         # Resumo teórico fundamentado na bibliografia
│   └── discussao_pbl.md          # Discussão técnica — resposta ao problema norteador
├── simulacoes/
│   ├── sim01_sinais_elementares.m   # 6 sinais básicos em tempo discreto
│   ├── sim02_operacoes_sinais.m     # Deslocamento, inversão e escalonamento
│   ├── sim03_energia_potencia.m     # Cálculo de energia e potência + classificação
│   ├── sim04_amostragem.m           # Processo de amostragem + aplicação PBL (sensor)
│   └── sim05_classificacao_sistemas.m  # Testes de linearidade, invariância e BIBO
├── resultados/
│   ├── fig01_impulso_unitario.png
│   ├── fig02_degrau_unitario.png
│   ├── fig03_exponencial_complexa.png
│   ├── fig04_senoide_discreta.png
│   ├── fig05_exponencial_real.png
│   ├── fig06_sinal_retangular.png
│   ├── fig07_sinal_original.png
│   ├── fig08_deslocamento.png
│   ├── fig09_inversao.png
│   ├── fig10_escalonamento.png
│   ├── fig11a_sinais_energia.png
│   ├── fig11b_sinais_potencia.png
│   ├── fig11c_nenhuma_categoria.png
│   ├── fig12_amostragem_basica.png
│   ├── fig13_comparacao_taxas.png
│   ├── fig14_sensor_temperatura.png
│   ├── fig15_teste_linearidade.png
│   ├── fig16_teste_invariancia.png
│   └── fig17_teste_bibo.png
└── README.md                     # Este arquivo
```

---

## Conteúdos Abordados

### Resumo Teórico (`teoria/resumo_teorico.md`)

- Definição de sinais contínuos e discretos
- Sequências elementares: impulso unitário, degrau unitário, exponencial complexa, senoide discreta, exponencial real, sinal retangular
- Operações com sinais: deslocamento (atraso/avanço), inversão (reflexão temporal), escalonamento
- Energia e potência de sinais — classificação em sinais de energia, potência ou nenhuma categoria
- Classificação de sistemas discretos: memória, linearidade, causalidade, invariância no tempo, estabilidade BIBO, invertibilidade

### Discussão PBL (`teoria/discussao_pbl.md`)

Resposta à pergunta norteadora, relacionando os conceitos estudados a sinais provenientes de sensores reais e identificando as propriedades estruturais necessárias para o correto processamento digital.

---

## Simulações Computacionais

Todas as simulações foram desenvolvidas em **GNU Octave** e geram gráficos automaticamente na pasta `resultados/` em **PNG (300 dpi)**.

| Script | Descrição | Figuras |
|--------|-----------|---------|
| `sim01_sinais_elementares.m` | Gera e visualiza os 6 sinais básicos em tempo discreto | fig01 a fig06 |
| `sim02_operacoes_sinais.m` | Demonstra deslocamento, inversão e escalonamento | fig07 a fig10 |
| `sim03_energia_potencia.m` | Calcula energia e potência, compara com fórmulas teóricas | fig11 |
| `sim04_amostragem.m` | Processo de amostragem + simulação de sensor de temperatura (PBL) | fig12 a fig14 |
| `sim05_classificacao_sistemas.m` | Testa linearidade, invariância no tempo e estabilidade BIBO | fig15 a fig17 |

### Como executar

```bash
# Requisito: GNU Octave instalado
sudo apt-get install -y octave

# Executar as simulações
cd simulacoes/
octave --no-gui sim01_sinais_elementares.m
octave --no-gui sim02_operacoes_sinais.m
octave --no-gui sim03_energia_potencia.m
octave --no-gui sim04_amostragem.m
octave --no-gui sim05_classificacao_sistemas.m
```

Os gráficos serão salvos automaticamente em `resultados/` no formato `*.png`.

---

## Resultados Principais

### Classificação Energética dos Sinais

| Sinal | Energia | Potência | Classe |
|-------|---------|----------|--------|
| $(0{,}8)^n u[n]$ | 2,78 | → 0 | Energia |
| $\delta[n]$ | 1 | → 0 | Energia |
| $2\cos(0{,}2\pi n)$ | → ∞ | 2,00 | Potência |
| $u[n]$ | → ∞ | 0,50 | Potência |
| $(1{,}1)^n$ | → ∞ | → ∞ | Nenhuma |

### Classificação dos Sistemas Discretos

| Sistema | Memória | Linear | Causal | Invariante | BIBO | Invertível |
|---------|---------|--------|--------|------------|------|------------|
| Acumulador | COM | SIM | SIM | SIM | NÃO | SIM |
| Média Móvel | COM | SIM | SIM | SIM | SIM | NÃO |
| $y[n] = x[n]^2$ | SEM | NÃO | SIM | SIM | SIM | NÃO |
| Compressor $x[2n]$ | SEM | SIM | NÃO | NÃO | SIM | NÃO |
| Diferença $x[n]-x[n-1]$ | COM | SIM | SIM | SIM | SIM | SIM |

---

## Referências Bibliográficas

- OPPENHEIM, A. V.; SCHAFER, R. W. *Processamento em Tempo Discreto de Sinais*. 3ª ed. São Paulo: Pearson, 2012.
- LATHI, B. P. *Sinais e Sistemas Lineares*. 2ª ed. Porto Alegre: Bookman, 2007.
- PROAKIS, J. G.; MANOLAKIS, D. G. *Digital Signal Processing: Principles, Algorithms, and Applications*. 4ª ed. Upper Saddle River: Prentice Hall, 2007.
