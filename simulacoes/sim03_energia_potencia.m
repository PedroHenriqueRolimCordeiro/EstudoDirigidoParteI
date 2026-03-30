%% =========================================================================
%% Simulação 3 — Energia e Potência de Sinais Discretos
%% =========================================================================
%% Calcula energia e potência de sinais típicos e classifica cada caso.
%% =========================================================================

clear; clc;
pds_academic_defaults;

%% Paleta usada nos gráficos
cor_azul = [0.00 0.20 0.45];
cor_verm = [0.55 0.10 0.10];

fprintf('================================================================\n');
fprintf('   CLASSIFICACAO ENERGETICA DOS SINAIS DISCRETOS\n');
fprintf('================================================================\n\n');

%% Sinal 1: exponencial decrescente (energia)
a = 0.8;
N_trunc = 200;
n1 = 0:N_trunc;
x1 = a .^ n1;

E1_num = sum(abs(x1).^2);
E1_teo = 1 / (1 - abs(a)^2);
P1_num = E1_num / (2*N_trunc + 1);

fprintf('--- Sinal 1: x[n] = (%.1f)^n u[n] ---\n', a);
fprintf('  Energia numerica:  E = %.6f\n', E1_num);
fprintf('  Energia teorica:   E = 1/(1-|a|^2) = %.6f\n', E1_teo);
fprintf('  Potencia media:    P = %.6f (-> 0)\n', P1_num);
fprintf('  Classificacao:     SINAL DE ENERGIA\n\n');

%% Sinal 2: senoide discreta (potência)
A = 2; omega = 0.2 * pi;
N_pot = 1000;
n2 = 0:N_pot;
x2 = A * cos(omega * n2);

E2_num = sum(abs(x2).^2);
P2_num = E2_num / length(n2);
P2_teo = A^2 / 2;

fprintf('--- Sinal 2: x[n] = %.0f cos(0.2pi n) ---\n', A);
fprintf('  Energia (N=%d):    E = %.2f (-> inf)\n', N_pot, E2_num);
fprintf('  Potencia numerica: P = %.6f\n', P2_num);
fprintf('  Potencia teorica:  P = A^2/2 = %.6f\n', P2_teo);
fprintf('  Classificacao:     SINAL DE POTENCIA\n\n');

%% Sinal 3: degrau unitário (potência)
N_deg = 1000;
n3 = -N_deg:N_deg;
x3 = double(n3 >= 0);

E3_num = sum(abs(x3).^2);
P3_num = E3_num / length(n3);
P3_teo = 0.5;

fprintf('--- Sinal 3: u[n] (degrau unitario) ---\n');
fprintf('  Energia (N=%d):    E = %.2f (-> inf)\n', N_deg, E3_num);
fprintf('  Potencia numerica: P = %.6f\n', P3_num);
fprintf('  Potencia teorica:  P = 1/2 = %.6f\n', P3_teo);
fprintf('  Classificacao:     SINAL DE POTENCIA\n\n');

%% Sinal 4: impulso unitário (energia)
n4 = -N_deg:N_deg;
x4 = double(n4 == 0);
E4_num = sum(abs(x4).^2);
P4_num = E4_num / length(n4);

fprintf('--- Sinal 4: delta[n] (impulso unitario) ---\n');
fprintf('  Energia:           E = %.6f\n', E4_num);
fprintf('  Potencia media:    P = %.8f (-> 0)\n', P4_num);
fprintf('  Classificacao:     SINAL DE ENERGIA\n\n');

%% Sinal 5: exponencial crescente (nenhuma categoria)
a5 = 1.1;
N_cresc = 100;
n5 = 0:N_cresc;
x5 = a5 .^ n5;

E5_num = sum(abs(x5).^2);
P5_num = E5_num / length(n5);

fprintf('--- Sinal 5: x[n] = (%.1f)^n u[n] ---\n', a5);
fprintf('  Energia (N=%d):    E = %.2e (-> inf)\n', N_cresc, E5_num);
fprintf('  Potencia (N=%d):   P = %.2e (-> inf)\n', N_cresc, P5_num);
fprintf('  Classificacao:     NENHUMA CATEGORIA (E=inf, P=inf)\n\n');

%% =========================================================================
%% Visualização
%% =========================================================================

% Figura 1: Sinais de energia
fig1 = figure('Position', [100 100 800 500], 'Visible', 'off');

subplot(2,1,1);
stem(n1(1:30), x1(1:30), 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', cor_azul);
title(sprintf('SINAL DE ENERGIA: x[n] = (0.8)^n u[n],   E = %.2f', E1_teo));
xlabel('n'); ylabel('x[n]'); grid on;

subplot(2,1,2);
stem(n4(N_deg-5:N_deg+5), x4(N_deg-5:N_deg+5), 'filled', 'LineWidth', 1.5, 'MarkerSize', 6, 'Color', cor_azul);
title(sprintf('SINAL DE ENERGIA: delta[n],   E = %.0f', E4_num));
xlabel('n'); ylabel('x[n]'); grid on;

pds_export_figure(fig1, '../resultados/fig11a_sinais_energia.png');

% Figura 2: Sinais de potência
fig2 = figure('Position', [100 100 800 500], 'Visible', 'off');

subplot(2,1,1);
stem(n2(1:60), x2(1:60), 'filled', 'LineWidth', 1.0, 'MarkerSize', 3, 'Color', cor_verm);
title(sprintf('SINAL DE POTENCIA: x[n] = 2cos(0.2*pi*n),   P = %.1f', P2_teo));
xlabel('n'); ylabel('x[n]'); grid on;

subplot(2,1,2);
n3_plot = N_deg-10:N_deg+10;
stem(n3(n3_plot+1), x3(n3_plot+1), 'filled', 'LineWidth', 1.5, 'MarkerSize', 5, 'Color', cor_verm);
title(sprintf('SINAL DE POTENCIA: u[n],   P = %.1f', P3_teo));
xlabel('n'); ylabel('x[n]'); grid on;

pds_export_figure(fig2, '../resultados/fig11b_sinais_potencia.png');

% Figura 3: Nenhuma categoria
fig3 = figure('Position', [100 100 700 350], 'Visible', 'off');
stem(n5(1:30), x5(1:30), 'filled', 'LineWidth', 1.2, 'MarkerSize', 4, 'Color', [0.85 0.1 0.1]);
title(sprintf('NENHUMA CATEGORIA: x[n] = (1.1)^n,   E -> inf,  P -> inf'));
xlabel('n'); ylabel('x[n]'); grid on;

pds_export_figure(fig3, '../resultados/fig11c_nenhuma_categoria.png');

%% --- Tabela resumo ---
fprintf('================================================================\n');
fprintf('   RESUMO DA CLASSIFICACAO\n');
fprintf('================================================================\n');
fprintf('  %-25s | %-10s | %-10s | %s\n', 'Sinal', 'Energia', 'Potencia', 'Classe');
fprintf('  %-25s | %-10s | %-10s | %s\n', '-----', '-------', '--------', '------');
fprintf('  %-25s | %-10.2f | %-10.6f | %s\n', '(0.8)^n u[n]', E1_teo, P1_num, 'ENERGIA');
fprintf('  %-25s | %-10.0f | %-10.6f | %s\n', 'delta[n]', E4_num, P4_num, 'ENERGIA');
fprintf('  %-25s | %-10s | %-10.2f | %s\n', '2cos(0.2*pi*n)', 'inf', P2_teo, 'POTENCIA');
fprintf('  %-25s | %-10s | %-10.2f | %s\n', 'u[n]', 'inf', P3_teo, 'POTENCIA');
fprintf('  %-25s | %-10s | %-10s | %s\n', '(1.1)^n', 'inf', 'inf', 'NENHUMA');
fprintf('\n=== Simulacao 3 concluida ===\n');
