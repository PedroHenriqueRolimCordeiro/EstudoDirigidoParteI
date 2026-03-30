# Discussão Técnica — Problema Norteador (PBL)

**Disciplina:** Processamento Digital de Sinais  
**Pergunta norteadora:** *Como representar matematicamente o comportamento temporal de um sensor real e quais propriedades estruturais devem ser analisadas para garantir o correto processamento digital desse sinal?*

---

## 1. Representação Matemática do Sinal de um Sensor

Um sensor real — como um acelerômetro, um termopar ou um microfone — gera um sinal analógico contínuo $x_a(t)$ que varia no tempo. Para que esse sinal possa ser processado digitalmente, ele precisa ser convertido em uma sequência discreta por meio do **processo de amostragem**:

$$x[n] = x_a(nT_s)$$

onde $T_s$ é o período de amostragem e $F_s = 1/T_s$ é a frequência de amostragem. Esse processo é realizado por um conversor analógico-digital (ADC) presente em sistemas embarcados.

Em termos de modelagem, o sinal de um sensor pode ser expresso como a soma de componentes determinísticas (fenômeno físico de interesse) e componentes estocásticas (ruído de medição):

$$x[n] = s[n] + \eta[n]$$

onde $s[n]$ é o sinal de interesse e $\eta[n]$ é o ruído. Por exemplo, na simulação `sim04_amostragem.m`, modelamos um sensor de temperatura como:

$$x[n] = 25 + 2\cos(2\pi \cdot 5 \cdot nT_s) + 0{,}5\cos(2\pi \cdot 0{,}5 \cdot nT_s) + \eta[n]$$

onde a componente de 5 Hz representa uma variação térmica rápida, a componente de 0,5 Hz representa uma oscilação lenta do ambiente, e $\eta[n]$ é ruído gaussiano com desvio padrão de 0,3 °C.

Uma vez que o sinal está na forma discreta $x[n]$, ele pode ser decomposto usando as **sequências elementares** estudadas: impulsos deslocados (pela propriedade de superposição $x[n] = \sum_k x[k]\,\delta[n-k]$), degraus (para modelar ativações e transições) e exponenciais (para modelar decaimento ou crescimento).

---

## 2. Propriedades Estruturais a Serem Analisadas

Após a representação matemática do sinal, é necessário analisar as propriedades do **sistema que o processará** (filtro, estimador, controlador). Conforme Lathi (2007), a identificação dessas propriedades determina quais ferramentas matemáticas são aplicáveis e quais garantias de desempenho podem ser obtidas.

### 2.1 Causalidade

Um sistema de processamento embarcado opera em **tempo real**: ele só tem acesso às amostras presentes e passadas do sensor, nunca às futuras. Portanto, o sistema **deve ser causal**:

$$y[n] = f(x[n], x[n-1], x[n-2], \ldots)$$

Essa exigência exclui filtros que dependem de amostras futuras (como diferenças progressivas $y[n] = x[n+1] - x[n]$) e impõe o uso de operações causais, como a **média móvel causal**:

$$y[n] = \frac{1}{M}\sum_{k=0}^{M-1} x[n-k]$$

### 2.2 Estabilidade BIBO

Se o sensor produzir uma leitura espúria (pico de ruído), o sistema de processamento não deve divergir. A estabilidade BIBO garante que toda entrada limitada produza saída limitada. Para sistemas LIT, a condição é que a resposta ao impulso seja absolutamente somável:

$$\sum_{n=-\infty}^{\infty} |h[n]| < \infty$$

Na simulação `sim05_classificacao_sistemas.m`, demonstra-se que o acumulador ($h[n] = u[n]$) é instável: a entrada constante $x[n] = u[n]$ produz $y[n] = n+1$, que cresce sem limite. Em sistemas de aquisição, esse comportamento pode resultar em saturação numérica e leituras incorretas.

### 2.3 Linearidade

Se o sistema é linear, a resposta a uma combinação de entradas corresponde à mesma combinação das respostas individuais. Essa propriedade é essencial para **separar componentes** do sinal: se o sensor registra um sinal com duas frequências, um filtro linear pode atenuar uma delas sem distorcer a outra. Sistemas não lineares (como $y[n] = x[n]^2$) introduzem harmônicas e intermodulação, comprometendo a fidelidade do processamento.

### 2.4 Invariância no Tempo

Um sistema invariante no tempo se comporta da mesma forma independentemente de *quando* o sinal é aplicado. No processamento de sensores, isso garante **consistência**: se o sensor medir a mesma temperatura em instantes distintos, o sistema deve produzir a mesma saída processada, apenas deslocada no tempo.

### 2.5 Caracterização Energética

Conforme Proakis e Manolakis (2007), determinar se o sinal é de **energia finita** ou de **potência finita** orienta a escolha das técnicas de análise:

- **Sinal de energia** (transientes, pulsos): usa-se correlação e densidade espectral de energia.
- **Sinal de potência** (sinais periódicos contínuos do sensor): usa-se autocorrelação e densidade espectral de potência.

Na simulação `sim03_energia_potencia.m`, verificamos que a exponencial decrescente $0{,}8^n u[n]$ tem energia finita $E = 1/(1 - 0{,}64) \approx 2{,}78$, enquanto a senoide tem potência finita $P = A^2/2$.

---

## 3. Síntese: Do Sensor ao Processamento Digital

O fluxo completo para o processamento correto do sinal de um sensor é:

```
Sensor → ADC (amostragem) → x[n] → Sistema de Processamento → y[n]
  │                                        │
  │  Verificar:                            │ Verificar:
  │  • Fs ≥ 2·Fmax (Nyquist)              │ • Causal? (tempo real)
  │  • Resolução do ADC                    │ • Estável BIBO? (sem divergência)
  │  • Classificar: energia ou potência    │ • Linear? (sem distorção)
  │                                        │ • Invariante no tempo? (consistência)
```

Em síntese, respondendo à pergunta norteadora:

1. **Representação matemática**: o sinal do sensor é convertido em uma sequência discreta $x[n] = x_a(nT_s)$ e pode ser modelado como soma de componentes senoidais, exponenciais e ruído, decompostas via impulsos deslocados.

2. **Propriedades estruturais**: para garantir o correto processamento digital, o sistema deve ser **causal** (processamento em tempo real), **estável BIBO** (robustez a perturbações), **linear** (preservação da fidelidade do sinal) e **invariante no tempo** (consistência das leituras). A **classificação energética** do sinal determina as ferramentas espectrais adequadas.

---

## Referências Bibliográficas

OPPENHEIM, A. V.; SCHAFER, R. W. *Processamento em Tempo Discreto de Sinais*. 3ª ed. São Paulo: Pearson, 2012.

LATHI, B. P. *Sinais e Sistemas Lineares*. 2ª ed. Porto Alegre: Bookman, 2007.

PROAKIS, J. G.; MANOLAKIS, D. G. *Digital Signal Processing: Principles, Algorithms, and Applications*. 4ª ed. Upper Saddle River: Prentice Hall, 2007.
