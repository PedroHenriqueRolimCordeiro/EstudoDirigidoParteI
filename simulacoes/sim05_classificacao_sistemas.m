%% =========================================================================
%% Simulação 5 — Classificação de Sistemas Discretos
%% O que faz: testa linearidade, invariância e BIBO; depois imprime resumo.
%% =========================================================================

clear; clc;
pds_academic_defaults;

%% Cores dos gráficos
cor_azul = [0.00 0.20 0.45];
cor_verm = [0.55 0.10 0.10];

fprintf('================================================================\n');
fprintf('   CLASSIFICACAO DE SISTEMAS DISCRETOS\n');
fprintf('================================================================\n\n');

%% Sinais de teste
% Entradas usadas nos testes de propriedades
N = 50;
n = 0:N-1;
x1 = (n == 10);
x2 = 0.5 * cos(0.2*pi*n);
a_coef = 3; b_coef = 2;
n0 = 5;

acumulador = @(x) cumsum(x);
quadratico = @(x) x.^2;

%% =========================================================================
%% Teste 1: linearidade
%% =========================================================================
% Compara T{a x1 + b x2} com aT{x1} + bT{x2}
fprintf('--- TESTE DE LINEARIDADE ---\n\n');

entrada_comb = a_coef*x1 + b_coef*x2;
saida_comb   = acumulador(entrada_comb);
saida_sep    = a_coef*acumulador(x1) + b_coef*acumulador(x2);
erro_acum    = max(abs(saida_comb - saida_sep));

if erro_acum < 1e-10; res = 'LINEAR'; else; res = 'NAO LINEAR'; end
fprintf('  Acumulador: erro = %.2e -> %s\n', erro_acum, res);

saida_comb_q = quadratico(entrada_comb);
saida_sep_q  = a_coef*quadratico(x1) + b_coef*quadratico(x2);
erro_quad    = max(abs(saida_comb_q - saida_sep_q));

if erro_quad < 1e-10; res = 'LINEAR'; else; res = 'NAO LINEAR'; end
fprintf('  Quadratico: erro = %.2e -> %s\n\n', erro_quad, res);

fig1 = figure('Position', [100 100 800 500], 'Visible', 'off');

subplot(2,1,1);
stem(n, saida_comb, 'filled', 'MarkerSize', 4, 'Color', cor_azul); hold on;
stem(n, saida_sep, 'o', 'MarkerSize', 6, 'Color', cor_verm, 'LineWidth', 1.2);
hold off;
title('Acumulador: Teste de Linearidade  (sobrepostos = LINEAR)');
legend('T\{ax_1+bx_2\}', 'aT\{x_1\}+bT\{x_2\}', 'Location', 'northwest');
xlabel('n'); ylabel('y[n]'); grid on;

subplot(2,1,2);
stem(n, saida_comb_q, 'filled', 'MarkerSize', 4, 'Color', cor_azul); hold on;
stem(n, saida_sep_q, 'o', 'MarkerSize', 6, 'Color', cor_verm, 'LineWidth', 1.2);
hold off;
title('Quadratico: Teste de Linearidade  (diferentes = NAO LINEAR)');
legend('T\{ax_1+bx_2\}', 'aT\{x_1\}+bT\{x_2\}', 'Location', 'northwest');
xlabel('n'); ylabel('y[n]'); grid on;

pds_export_figure(fig1, '../resultados/fig15_teste_linearidade.png');

%% =========================================================================
%% Teste 2: invariância no tempo
%% =========================================================================
% Compara T{x[n-n0]} com y[n-n0]
fprintf('--- TESTE DE INVARIANCIA NO TEMPO ---\n\n');

x_teste = sin(0.3*pi*n);
y_orig = acumulador(x_teste);
x_desl = [zeros(1, n0), x_teste(1:end-n0)];
y_ent_desl = acumulador(x_desl);
y_sai_desl = [zeros(1, n0), y_orig(1:end-n0)];
erro_inv = max(abs(y_ent_desl - y_sai_desl));

if erro_inv < 1e-10; res = 'INVARIANTE'; else; res = 'VARIANTE'; end
fprintf('  Acumulador: erro = %.2e -> %s NO TEMPO\n', erro_inv, res);

compressor = @(x) x(1:2:end);
N2 = 100; n2 = 0:N2-1;
x_t2 = sin(0.1*pi*n2);
x_t2_d = [zeros(1, n0), x_t2(1:end-n0)];
y_comp_orig = compressor(x_t2);
y_comp_din  = compressor(x_t2_d);
y_comp_dout = [zeros(1, n0), y_comp_orig(1:end-n0)];
len = min(length(y_comp_din), length(y_comp_dout));
erro_comp = max(abs(y_comp_din(1:len) - y_comp_dout(1:len)));

if erro_comp < 1e-10; res = 'INVARIANTE'; else; res = 'VARIANTE'; end
fprintf('  Compressor x[2n]: erro = %.2e -> %s NO TEMPO\n\n', erro_comp, res);

fig2 = figure('Position', [100 100 800 500], 'Visible', 'off');

subplot(2,1,1);
stem(n, y_ent_desl, 'filled', 'MarkerSize', 4, 'Color', cor_azul); hold on;
stem(n, y_sai_desl, 'o', 'MarkerSize', 6, 'Color', cor_verm, 'LineWidth', 1.2);
hold off;
title(sprintf('Acumulador: Teste de Invariancia  (n_0 = %d)  ->  INVARIANTE', n0));
legend('T\{x[n-n_0]\}', 'y[n-n_0]', 'Location', 'northwest');
xlabel('n'); ylabel('y[n]'); grid on;

subplot(2,1,2);
nn = 0:len-1;
stem(nn, y_comp_din(1:len), 'filled', 'MarkerSize', 4, 'Color', cor_azul); hold on;
stem(nn, y_comp_dout(1:len), 'o', 'MarkerSize', 6, 'Color', cor_verm, 'LineWidth', 1.2);
hold off;
title(sprintf('Compressor x[2n]: Teste de Invariancia  (n_0 = %d)  ->  VARIANTE', n0));
legend('T\{x[n-n_0]\}', 'y[n-n_0]', 'Location', 'northwest');
xlabel('n'); ylabel('y[n]'); grid on;

pds_export_figure(fig2, '../resultados/fig16_teste_invariancia.png');

%% =========================================================================
%% Teste 3: estabilidade BIBO
%% =========================================================================
% Verifica somabilidade absoluta de h[n] e resposta ao degrau
fprintf('--- TESTE DE ESTABILIDADE BIBO ---\n\n');

h_est = 0.8 .^ n;
soma_est = sum(abs(h_est));
fprintf('  h[n] = (0.8)^n u[n]: sum|h| = %.4f (< inf) -> ESTAVEL\n', soma_est);
fprintf('  Teorico: 1/(1-0.8) = %.4f\n\n', 1/(1-0.8));

h_inst = ones(1, N);
soma_inst = sum(abs(h_inst));
fprintf('  h[n] = u[n] (acumulador): sum|h| = %.0f (-> inf) -> INSTAVEL\n', soma_inst);

x_bibo = ones(1, N);
y_bibo = cumsum(x_bibo);
fprintf('  Verificacao: x[n]=u[n], y[n]=n+1 -> y[49] = %d (ilimitada)\n\n', y_bibo(end));

fig3 = figure('Position', [100 100 800 500], 'Visible', 'off');

subplot(2,1,1);
y_est = conv(h_est, x_bibo);
stem(n, y_est(1:N), 'filled', 'MarkerSize', 4, 'Color', cor_azul);
title('BIBO ESTAVEL: h[n] = (0.8)^n u[n],  entrada u[n]  ->  saida LIMITADA');
xlabel('n'); ylabel('y[n]'); grid on;

subplot(2,1,2);
stem(n, y_bibo, 'filled', 'MarkerSize', 4, 'Color', cor_verm);
title('BIBO INSTAVEL: acumulador,  entrada u[n]  ->  saida y[n] = n+1 (ILIMITADA)');
xlabel('n'); ylabel('y[n]'); grid on;

pds_export_figure(fig3, '../resultados/fig17_teste_bibo.png');

%% =========================================================================
%% Tabela resumo
%% =========================================================================
fprintf('\n================================================================\n');
fprintf('   TABELA RESUMO — CLASSIFICACAO DOS SISTEMAS\n');
fprintf('================================================================\n');
fprintf('  %-22s | %-7s | %-7s | %-7s | %-10s | %-5s | %-6s\n', ...
        'Sistema', 'Memoria', 'Linear', 'Causal', 'Invariante', 'BIBO', 'Inv.');
fprintf('  %-22s | %-7s | %-7s | %-7s | %-10s | %-5s | %-6s\n', ...
        '------', '------', '------', '------', '---------', '----', '----');
fprintf('  %-22s | %-7s | %-7s | %-7s | %-10s | %-5s | %-6s\n', ...
        'Acumulador', 'COM', 'SIM', 'SIM', 'SIM', 'NAO', 'SIM');
fprintf('  %-22s | %-7s | %-7s | %-7s | %-10s | %-5s | %-6s\n', ...
        'Media Movel (M=5)', 'COM', 'SIM', 'SIM', 'SIM', 'SIM', 'NAO');
fprintf('  %-22s | %-7s | %-7s | %-7s | %-10s | %-5s | %-6s\n', ...
        'y[n] = x[n]^2', 'SEM', 'NAO', 'SIM', 'SIM', 'SIM', 'NAO');
fprintf('  %-22s | %-7s | %-7s | %-7s | %-10s | %-5s | %-6s\n', ...
        'Compressor x[2n]', 'SEM', 'SIM', 'NAO', 'NAO', 'SIM', 'NAO');
fprintf('  %-22s | %-7s | %-7s | %-7s | %-10s | %-5s | %-6s\n', ...
        'Diferenca x[n]-x[n-1]', 'COM', 'SIM', 'SIM', 'SIM', 'SIM', 'SIM');

fprintf('\n=== Simulacao 5 concluida ===\n');
