# Resumo Teórico — Modelagem de Sinais e Sistemas Discretos

**Disciplina:** Processamento Digital de Sinais

---

## Introdução

No estudo de sinais provenientes de sensores (temperatura, vibração, áudio, entre outros), uma etapa fundamental consiste em representar matematicamente o fenômeno físico para posterior análise computacional. Este resumo apresenta, portanto, os conceitos essenciais de sinais discretos e das propriedades dos sistemas que os processam.

As referências adotadas seguem a bibliografia clássica da área. Oppenheim e Schafer (2012) definem sinais discretos como sequências obtidas por amostragem de sinais contínuos. Lathi (2007) destaca que a modelagem adequada de sistemas depende da verificação de propriedades como linearidade, causalidade, estabilidade, invariância no tempo e memória. Proakis e Manolakis (2007), por sua vez, enfatizam que a caracterização energética e temporal do sinal orienta a escolha das técnicas de processamento mais apropriadas.

---

## 1. Definição de Sinais Contínuos e Discretos

Um **sinal de tempo contínuo** é definido para qualquer valor real de *t*, sendo representado por *x(t)*. Já um **sinal de tempo discreto** é definido em instantes inteiros *n*, sendo representado por *x[n]*.

Segundo Oppenheim e Schafer (Cap. 2), sinais de tempo discreto podem surgir naturalmente (como dados econômicos amostrados diariamente) ou ser obtidos a partir da **amostragem** de sinais contínuos:

$$x[n] = x_a(nT)$$

onde $T$ é o período de amostragem e $x_a(t)$ é o sinal analógico original. Esse procedimento viabiliza a análise digital de fenômenos físicos originalmente contínuos.

---

## 2. Sequências Elementares

As sequências a seguir são recorrentes em PDS e funcionam como blocos fundamentais de modelagem.

### 2.1 Impulso Unitário (Delta de Kronecker)

$$\delta[n] = \begin{cases} 1, & n = 0 \\ 0, & n \neq 0 \end{cases}$$

O impulso unitário é a base para a representação de sinais discretos. Qualquer sequência pode ser escrita como soma de impulsos deslocados:

$$x[n] = \sum_{k=-\infty}^{\infty} x[k]\,\delta[n - k]$$

### 2.2 Degrau Unitário

$$u[n] = \begin{cases} 1, & n \geq 0 \\ 0, & n < 0 \end{cases}$$

O degrau unitário se relaciona com o impulso por uma soma acumulada:

$$u[n] = \sum_{k=-\infty}^{n} \delta[k]$$

E, inversamente, o impulso é a primeira diferença regressiva do degrau:

$$\delta[n] = u[n] - u[n-1]$$

### 2.3 Exponencial Complexa

A forma geral de uma sequência exponencial é:

$$x[n] = A\,\alpha^n$$

Quando $\alpha = |\alpha|\,e^{j\omega_0}$ e $A = |A|\,e^{j\phi}$, temos:

$$x[n] = |A|\,|\alpha|^n \cos(\omega_0 n + \phi) + j\,|A|\,|\alpha|^n \sin(\omega_0 n + \phi)$$

Para $|\alpha| = 1$, obtém-se a **exponencial complexa pura**:

$$x[n] = |A|\,e^{j(\omega_0 n + \phi)}$$

cujas partes real e imaginária correspondem a senoides. Um ponto relevante em tempo discreto é que frequências $\omega_0$ e $(\omega_0 + 2\pi r)$ são **equivalentes**, pois $e^{j(\omega_0 + 2\pi)n} = e^{j\omega_0 n}$. Portanto, é suficiente analisar frequências em $0 \leq \omega_0 < 2\pi$ (ou $-\pi < \omega_0 \leq \pi$).

Outra observação importante é que as senoides discretas **nem sempre são periódicas**. Para existir período, deve valer $\omega_0 N = 2\pi k$ para algum inteiro $k$, o que nem sempre ocorre.

---

## 3. Operações com Sinais

### 3.1 Deslocamento (Atraso/Avanço)

O deslocamento de uma sequência por $n_0$ amostras produz:

$$y[n] = x[n - n_0]$$

- Se $n_0 > 0$: **atraso** (desloca para a direita)
- Se $n_0 < 0$: **avanço** (desloca para a esquerda)

### 3.2 Inversão (Reflexão Temporal)

A inversão de uma sequência em torno de $n = 0$ resulta em:

$$y[n] = x[-n]$$

Graficamente, essa operação corresponde a um espelhamento de $x[n]$ em torno do eixo vertical.

### 3.3 Escalonamento (Multiplicação por Constante)

$$y[n] = c \cdot x[n]$$

onde $c$ é uma constante real ou complexa. Essa operação altera a amplitude do sinal sem modificar sua forma temporal.

---

## 4. Energia e Potência de Sinais

Proakis e Manolakis (2007) destacam que a caracterização por energia e potência é essencial para a escolha da metodologia de análise. Ao identificar se o sinal possui energia finita ou potência finita, torna-se mais objetiva a seleção de ferramentas espectrais e estatísticas.

A **energia total** de um sinal de tempo discreto é definida como:

$$E = \sum_{n=-\infty}^{\infty} |x[n]|^2$$

A **potência média** de um sinal é:

$$P = \lim_{N \to \infty} \frac{1}{2N+1} \sum_{n=-N}^{N} |x[n]|^2$$

Com base nessas definições, os sinais podem ser agrupados em três categorias:

- **Sinal de energia**: $0 < E < \infty$ (consequentemente $P = 0$). Exemplo: $x[n] = a^n u[n]$ com $|a| < 1$, cuja energia é $E = \frac{1}{1-|a|^2}$.
- **Sinal de potência**: $0 < P < \infty$ (consequentemente $E = \infty$). Exemplo: senoides, degrau unitário.
- Sinais que **não são de energia nem de potência**: quando $E = \infty$ e $P = \infty$ (exemplo: $x[n] = n$).

---

## 5. Classificação de Sistemas Discretos

Um sistema de tempo discreto pode ser interpretado como uma transformação $T\{\cdot\}$ que mapeia a entrada $x[n]$ na saída $y[n]$:

$$y[n] = T\{x[n]\}$$

Lathi (2007) enfatiza que essa classificação não é apenas descritiva: ela define diretamente quais ferramentas podem ser empregadas na análise. Por exemplo, em sistemas lineares e invariantes no tempo, resposta ao impulso e convolução tornam-se ferramentas centrais.

### 5.1 Sistemas Com e Sem Memória

- **Sem memória**: a saída $y[n_0]$ depende **apenas** de $x[n_0]$ no mesmo instante. Exemplo: $y[n] = x[n]^2$.
- **Com memória**: a saída depende de amostras de outros instantes. Exemplo: o **acumulador** $y[n] = \sum_{k=-\infty}^{n} x[k]$ e a **média móvel** $y[n] = \frac{1}{M_1+M_2+1}\sum_{k=-M_1}^{M_2} x[n-k]$.

### 5.2 Sistemas Lineares e Não Lineares

Um sistema é **linear** se satisfaz o **princípio da superposição** para quaisquer entradas $x_1[n]$, $x_2[n]$ e constantes $a$, $b$:

$$T\{a\,x_1[n] + b\,x_2[n]\} = a\,T\{x_1[n]\} + b\,T\{x_2[n]\}$$

Em outras palavras, devem ser satisfeitas simultaneamente as propriedades de aditividade e homogeneidade.

- **Linear**: o acumulador (Eq. 2.26 do livro).
- **Não linear**: $y[n] = \log_{10}(|x[n]|)$. Contraexemplo: para $x_1[n] = 1$ e $x_2[n] = 10$, $\log_{10}(11) \neq \log_{10}(1) + \log_{10}(10)$.

### 5.3 Sistemas Causais e Não Causais

- **Causal**: a saída em $n_0$ depende apenas do presente e do passado ($n \leq n_0$). Exemplo: $y[n] = x[n] - x[n-1]$.
- **Não causal**: a saída depende de valores futuros da entrada. Exemplo: $y[n] = x[n+1] - x[n]$.

### 5.4 Sistemas Invariantes e Variantes no Tempo

Um sistema é **invariante no tempo** (ou invariante a deslocamento) se um deslocamento na entrada causa o mesmo deslocamento na saída: se $T\{x[n]\} = y[n]$, então:

$$T\{x[n - n_0]\} = y[n - n_0], \quad \forall\, n_0$$

- **Invariante no tempo**: o acumulador. Pode-se verificar que $y_1[n] = \sum_{k=-\infty}^{n} x[k - n_0] = y[n - n_0]$.
- **Variante no tempo**: o compressor $y[n] = x[Mn]$, pois um atraso na entrada não produz o mesmo atraso na saída.

### 5.5 Estabilidade BIBO

Um sistema é **BIBO estável** (*Bounded-Input, Bounded-Output*) quando toda entrada limitada produz saída limitada. Formalmente, se $|x[n]| \leq B_x < \infty$ para todo $n$, então existe $B_y < \infty$ tal que $|y[n]| \leq B_y$ para todo $n$.

Para sistemas **LIT** (Lineares e Invariantes no Tempo), a condição necessária e suficiente para estabilidade BIBO é que a resposta ao impulso seja **absolutamente somável**:

$$\sum_{n=-\infty}^{\infty} |h[n]| < \infty$$

- **Estável**: $h[n] = a^n u[n]$ com $|a| < 1$, pois $\sum |a|^n = \frac{1}{1 - |a|} < \infty$.
- **Instável**: o acumulador, pois $h[n] = u[n]$ e $\sum_{n=0}^{\infty} 1 = \infty$. Com $x[n] = u[n]$, a saída vira $y[n] = n + 1$ e cresce sem limite.

### 5.6 Invertibilidade

Um sistema é **invertível** se existe um **sistema inverso** que recupera a entrada original a partir da saída. Para sistemas LIT, isso significa que existe $h_i[n]$ tal que:

$$h[n] * h_i[n] = \delta[n]$$

Exemplo: o sistema de diferenças regressivas ($y[n] = x[n] - x[n-1]$) é o sistema inverso do acumulador, pois a cascata dos dois resulta na identidade:

$$u[n] * (\delta[n] - \delta[n-1]) = u[n] - u[n-1] = \delta[n]$$

Um sistema **não invertível** é aquele em que entradas diferentes podem gerar a mesma saída (exemplo: $y[n] = x[n]^2$, pois $x[n]$ e $-x[n]$ resultam no mesmo valor).

---

## Referências Bibliográficas

OPPENHEIM, A. V.; SCHAFER, R. W. *Processamento em Tempo Discreto de Sinais*. 3ª ed. São Paulo: Pearson, 2012.

LATHI, B. P. *Sinais e Sistemas Lineares*. 2ª ed. Porto Alegre: Bookman, 2007.

PROAKIS, J. G.; MANOLAKIS, D. G. *Digital Signal Processing: Principles, Algorithms, and Applications*. 4ª ed. Upper Saddle River: Prentice Hall, 2007.
