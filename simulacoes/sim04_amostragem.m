%% =========================================================================
%% Simulação 4 — Processo de Amostragem
%% O que faz: mostra contínuo -> discreto e um caso prático com sensor.
%% =========================================================================

clear; clc;
pds_academic_defaults;

%% Cores dos gráficos
cor_azul = [0.00 0.20 0.45];
cor_verm = [0.55 0.10 0.10];

%% =========================================================================
%% Exemplo 1: senoide de 50 Hz com Fs = 500 Hz
%% =========================================================================
% Sinal contínuo de referência
f0 = 50;
t = 0:0.0001:0.04;
x_cont = cos(2*pi*f0*t);

% Amostragem uniforme
Ts = 0.002; Fs = 1/Ts;
n_am = 0:Ts:0.04;
x_disc = cos(2*pi*f0*n_am);

fig1 = figure('Position', [100 100 800 400], 'Visible', 'off');
plot(t, x_cont, '-', 'LineWidth', 1.5, 'Color', cor_azul); hold on;
stem(n_am, x_disc, 'filled', 'LineWidth', 1.2, 'MarkerSize', 6, 'Color', cor_verm);
hold off;
xlabel('Tempo (s)'); ylabel('Amplitude');
title(sprintf('Processo de Amostragem:  f_0 = %d Hz,  F_s = %d Hz', f0, Fs));
legend('Sinal Continuo x(t)', sprintf('Amostras x[n]  (F_s = %d Hz)', Fs), ...
       'Location', 'northeast');
grid on;
pds_export_figure(fig1, '../resultados/fig12_amostragem_basica.png');

%% =========================================================================
%% Exemplo 2: comparação de diferentes Fs
%% =========================================================================
% Compara alta, média e baixa taxa de amostragem
Fs_vals = [500, 200, 110];

fig2 = figure('Position', [100 100 800 700], 'Visible', 'off');
for k = 1:length(Fs_vals)
    Fs_k = Fs_vals(k);
    Ts_k = 1/Fs_k;
    n_k = 0:Ts_k:0.04;
    x_k = cos(2*pi*f0*n_k);

    subplot(3,1,k);
    plot(t, x_cont, '-', 'LineWidth', 1.2, 'Color', cor_azul); hold on;
    stem(n_k, x_k, 'filled', 'LineWidth', 1.0, 'MarkerSize', 4, 'Color', cor_verm);
    hold off;
    ylabel('Amplitude');
    title(sprintf('F_s = %d Hz   (%.1fx a frequencia do sinal)', Fs_k, Fs_k/f0));
    grid on;
end
xlabel('Tempo (s)');
pds_export_figure(fig2, '../resultados/fig13_comparacao_taxas.png');

%% =========================================================================
%% Exemplo 3: sensor de temperatura com ruído
%% =========================================================================
% Modelo simples: componente DC + variações + ruído
Fs_sensor = 100;
duracao = 2;
n_sensor = 0:1/Fs_sensor:duracao;

temp_base = 25;
variacao = 2 * cos(2*pi*5*n_sensor) + 0.5 * cos(2*pi*0.5*n_sensor);
ruido = 0.3 * randn(size(n_sensor));
sinal_sensor = temp_base + variacao + ruido;

t_cont = 0:0.001:duracao;
sinal_cont = temp_base + 2*cos(2*pi*5*t_cont) + 0.5*cos(2*pi*0.5*t_cont);

fig3 = figure('Position', [100 100 800 500], 'Visible', 'off');

subplot(2,1,1);
plot(t_cont, sinal_cont, '-', 'LineWidth', 1.2, 'Color', cor_azul); hold on;
stem(n_sensor, sinal_sensor, 'filled', 'MarkerSize', 2, 'Color', cor_verm);
hold off;
xlabel('Tempo (s)'); ylabel('Temperatura (C)');
title(sprintf('Aplicacao PBL: Sensor de Temperatura   (F_s = %d Hz)', Fs_sensor));
legend('Sinal ideal', 'Amostras com ruido', 'Location', 'northeast');
grid on;

subplot(2,1,2);
stem(0:length(sinal_sensor)-1, sinal_sensor, 'filled', 'MarkerSize', 2, 'Color', cor_azul);
xlabel('n (indice da amostra)'); ylabel('Temperatura (C)');
title('Sinal discreto x[n] — sequencia de amostras');
grid on;
pds_export_figure(fig3, '../resultados/fig14_sensor_temperatura.png');

fprintf('\n=== Simulacao 4 concluida ===\n');
fprintf('Processo de amostragem demonstrado com 3 exemplos.\n');
