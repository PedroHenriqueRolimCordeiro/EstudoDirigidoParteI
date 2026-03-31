%% =========================================================================
%% Simulação 1 — Sequências Elementares (6 Sinais Básicos)
%% =========================================================================
%% Gera e plota os 6 sinais básicos de tempo discreto usados no estudo.
%% =========================================================================

clear; clc;
% Carrega as configurações visuais padrão do projeto
pds_academic_defaults;

%% Paleta usada nos gráficos
cor_azul = [0.00 0.20 0.45];
cor_verm = [0.55 0.10 0.10];
cor_verd = [0.10 0.35 0.20];
cor_roxo = [0.35 0.20 0.55];

%% Índice comum
n = -10:10;

%% =========================================================================
%% Sinal 1: impulso unitário delta[n]
%% =========================================================================
% A condição (n == 0) gera o valor 1 apenas na origem e 0 no restante
delta = (n == 0);

fig1 = figure('Position', [100 100 700 350], 'Visible', 'off');
stem(n, delta, 'filled', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', cor_azul);
xlabel('n (amostras)'); ylabel('\delta[n]');
title('Impulso Unitario \delta[n]');
ylim([-0.2, 1.5]);
% Exporta a figura gerada para a pasta de resultados
pds_export_figure(fig1, '../resultados/fig01_impulso_unitario.png');

%% =========================================================================
%% Sinal 2: degrau unitário u[n]
%% =========================================================================
% Gera o valor 1 para n >= 0, e 0 para valores negativos
u = (n >= 0);

fig2 = figure('Position', [100 100 700 350], 'Visible', 'off');
stem(n, u, 'filled', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', cor_azul);
xlabel('n (amostras)'); ylabel('u[n]');
title('Degrau Unitario u[n]');
ylim([-0.2, 1.5]);
pds_export_figure(fig2, '../resultados/fig02_degrau_unitario.png');

%% =========================================================================
%% Sinal 3: exponencial complexa
%% =========================================================================
n_exp = 0:50;
omega0 = 0.3 * pi;
x_comp = exp(1j * omega0 * n_exp);

fig3 = figure('Position', [100 100 800 500], 'Visible', 'off');
subplot(2,1,1);
stem(n_exp, real(x_comp), 'filled', 'LineWidth', 1.0, 'MarkerSize', 3, 'Color', cor_azul);
xlabel('n'); ylabel('Parte Real');
title('Exponencial Complexa — Re\{e^{j0.3\pi n}\} = cos(0.3\pi n)');

subplot(2,1,2);
stem(n_exp, imag(x_comp), 'filled', 'LineWidth', 1.0, 'MarkerSize', 3, 'Color', cor_verm);
xlabel('n'); ylabel('Parte Imaginaria');
title('Exponencial Complexa — Im\{e^{j0.3\pi n}\} = sen(0.3\pi n)');
pds_export_figure(fig3, '../resultados/fig03_exponencial_complexa.png');

%% =========================================================================
%% Sinal 4: senoide discreta
%% =========================================================================
n_sen = 0:60;
A = 2; omega = 0.2 * pi; phi = 0;
% O período fundamental é N = 2*pi / omega = 2*pi / 0.2*pi = 10 amostras
x_sen = A * cos(omega * n_sen + phi);

fig4 = figure('Position', [100 100 800 350], 'Visible', 'off');
stem(n_sen, x_sen, 'filled', 'LineWidth', 1.0, 'MarkerSize', 3, 'Color', cor_azul);
xlabel('n (amostras)'); ylabel('x[n]');
title('Senoide Discreta: x[n] = 2 cos(0.2\pi n),  Periodo N = 10');
pds_export_figure(fig4, '../resultados/fig04_senoide_discreta.png');

%% =========================================================================
%% Sinal 5: exponencial real
%% =========================================================================
n_real = 0:20;

fig5 = figure('Position', [100 100 800 650], 'Visible', 'off');

subplot(3,1,1);
stem(n_real, 0.8.^n_real, 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', cor_azul);
xlabel('n'); ylabel('x[n]');
title('Decrescente (a = 0.8) — Sistema Estavel');

subplot(3,1,2);
stem(n_real, 1.1.^n_real, 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', cor_verm);
xlabel('n'); ylabel('x[n]');
title('Crescente (a = 1.1) — Sistema Instavel');

subplot(3,1,3);
stem(n_real, (-0.8).^n_real, 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', cor_roxo);
xlabel('n'); ylabel('x[n]');
title('Alternante (a = -0.8)');
pds_export_figure(fig5, '../resultados/fig05_exponencial_real.png');

%% =========================================================================
%% Sinal 6: pulso retangular
%% =========================================================================
n_ret = 0:50;
N_janela = 11;
% Cria um pulso com valor 1 iniciando em n=10 e com a largura exata de N_janela
x_ret = double(n_ret >= 10 & n_ret <= 10 + N_janela - 1);

fig6 = figure('Position', [100 100 700 350], 'Visible', 'off');
stem(n_ret, x_ret, 'filled', 'LineWidth', 1.5, 'MarkerSize', 5, 'Color', cor_azul);
xlabel('n (amostras)'); ylabel('x[n]');
title(sprintf('Sinal Retangular — Janela de %d amostras (n=10 a n=20)', N_janela));
ylim([-0.2, 1.5]);
pds_export_figure(fig6, '../resultados/fig06_sinal_retangular.png');

fprintf('\n=== Simulacao 1 concluida ===\n');
fprintf('6 sinais basicos gerados e salvos em ../resultados/\n');
