%% =========================================================================
%% Simulação 2 — Operações com Sinais Discretos
%% =========================================================================
%% Mostra deslocamento, inversão e escalonamento usando x[n] = 0.9^n u[n].
%% =========================================================================

clear; clc;
pds_academic_defaults;

%% Paleta usada nos gráficos
cor_azul = [0.00 0.20 0.45];
cor_verm = [0.55 0.10 0.10];
cor_verd = [0.10 0.35 0.20];
cor_roxo = [0.35 0.20 0.55];

%% Sinal base
n = -5:20;
x = (0.9 .^ n) .* (n >= 0);

fig1 = figure('Position', [100 100 700 350], 'Visible', 'off');
stem(n, x, 'filled', 'LineWidth', 1.5, 'MarkerSize', 5, 'Color', cor_azul);
xlabel('n (amostras)'); ylabel('x[n]');
title('Sinal Original: x[n] = (0.9)^n u[n]');
grid on;
pds_export_figure(fig1, '../resultados/fig07_sinal_original.png');

%% =========================================================================
%% Operação 1: deslocamento
%% =========================================================================
n0_atraso = 5;
n0_avanco = -3;
x_atraso = (0.9 .^ (n - n0_atraso)) .* ((n - n0_atraso) >= 0);
x_avanco = (0.9 .^ (n - n0_avanco)) .* ((n - n0_avanco) >= 0);

fig2 = figure('Position', [100 100 800 700], 'Visible', 'off');

subplot(3,1,1);
stem(n, x, 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', cor_azul);
ylabel('x[n]'); title('Original: x[n]'); grid on;

subplot(3,1,2);
stem(n, x_atraso, 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', cor_verm);
ylabel('x[n-5]');
title('Atraso de 5 amostras: x[n - 5]   (desloca para a direita)');
grid on;

subplot(3,1,3);
stem(n, x_avanco, 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', cor_verd);
ylabel('x[n+3]');
title('Avanco de 3 amostras: x[n + 3]   (desloca para a esquerda)');
grid on;
xlabel('n (amostras)');
pds_export_figure(fig2, '../resultados/fig08_deslocamento.png');

%% =========================================================================
%% Operação 2: inversão temporal
%% =========================================================================
x_invertido = (0.9 .^ (-n)) .* ((-n) >= 0);

fig3 = figure('Position', [100 100 800 500], 'Visible', 'off');

subplot(2,1,1);
stem(n, x, 'filled', 'LineWidth', 1.2, 'MarkerSize', 5, 'Color', cor_azul);
ylabel('x[n]'); title('Original: x[n]'); grid on;

subplot(2,1,2);
stem(n, x_invertido, 'filled', 'LineWidth', 1.2, 'MarkerSize', 5, 'Color', cor_roxo);
ylabel('x[-n]');
title('Inversao: y[n] = x[-n]   (reflexao em torno de n=0)');
grid on;
xlabel('n (amostras)');
pds_export_figure(fig3, '../resultados/fig09_inversao.png');

%% =========================================================================
%% Operação 3: escalonamento
%% =========================================================================
c1 = 3;
c3 = -2;

fig4 = figure('Position', [100 100 800 700], 'Visible', 'off');

subplot(3,1,1);
stem(n, x, 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', cor_azul);
ylabel('x[n]'); title('Original: x[n]'); grid on;

subplot(3,1,2);
stem(n, c1*x, 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', cor_verm);
ylabel('y[n]');
title(sprintf('Amplificacao: y[n] = %d * x[n]', c1));
grid on;

subplot(3,1,3);
stem(n, c3*x, 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', cor_roxo);
ylabel('y[n]');
title(sprintf('Inversao + Escala: y[n] = %d * x[n]', c3));
grid on;
xlabel('n (amostras)');
pds_export_figure(fig4, '../resultados/fig10_escalonamento.png');

fprintf('\n=== Simulacao 2 concluida ===\n');
fprintf('Operacoes de deslocamento, inversao e escalonamento demonstradas.\n');
