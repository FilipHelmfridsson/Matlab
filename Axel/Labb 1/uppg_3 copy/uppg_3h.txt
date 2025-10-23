clear; clc;

steps_amount = [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192]; % olika n att testa
T = 24;              % Slutpunkt för intervallet
y0 = 2;              % Begynnelsevillkor

% Jämför med analytisk lösning
analytisk_f = @(t) (518/265)*exp(-(3/4)*t) + ...
                   (12/265)*cos(4*t) + (64/265)*sin(4*t);

% --- Loop över olika n ---
figure; hold on;
err_list = zeros(1, length(steps_amount));    % preallocate error array
for i = 1:length(steps_amount)
    n = steps_amount(i);
    h = T / n;
    t = linspace(0, T, n+1);
    y = zeros(1, n+1);
    y(1) = y0;

    % --- Anropa bakåt Euler ---
    y = bakat_euler(t, y, h, n);

    % --- Beräkna fel ---
    err = abs(y(end) - analytisk_f(T));
    err_list(i) = err;                         % store error

    % --- Skriv ut resultat ---
    fprintf('n = %3d, h = %.4f, y(24) = %.6f, fel = %.3e\n', n, h, y(end), err);

    % --- Rita ut lösningen ---
    plot(t, y, 'DisplayName', sprintf('n = %d', n), 'LineWidth', 1.2);
end

% --- Rita ut analytisk lösning ---
fplot(analytisk_f, [0 T], 'k--', 'LineWidth',1.5, 'DisplayName', 'Analytisk');
hold off;

% --- Felplottning ---
figure; hold on;
plot(steps_amount, err_list, 'o-')
xlabel('n (antal delintervall)');
ylabel('Fel vid t = 24');
title('Fel för olika n (Bakåt Euler)');
set(gca, 'XScale', 'log');    % valfritt: visa på log-skala
set(gca, 'YScale', 'log');    % valfritt: visa på log-skala
legend('Error'); grid on;