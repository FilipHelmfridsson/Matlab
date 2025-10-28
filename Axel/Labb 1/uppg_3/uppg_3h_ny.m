clear; clc; close all;

T = 24;        % slut-tid
y0 = 2;        % begynnelsevärde
analytisk_f = @(t) (518/265)*exp(-(3/4)*t) + ...
                   (12/265)*cos(4*t) + (64/265)*sin(4*t);

N_values = 2.^(0:9);   % n = 1, 2, 4, 8, ..., 512


for i = 1:length(N_values)
    n = N_values(i);
    h = T / n;
    t = linspace(0, T, n+1);
    y = zeros(1, n+1);
    y(1) = y0;

    y_list = bakat_euler(t, y, h, n);
    
    % Analytisk lösning och fel
    y_exact = analytisk_f(t);
    err = abs(y_list - y_exact);
    e_end = err(end);

    % Plot för varje n
    figure(1); hold on;
    plot(t, y_list, 'DisplayName', sprintf('n = %d', n));
end

% Lägg till analytisk lösning
t_fine = linspace(0, T, 2000);
plot(t_fine, analytisk_f(t_fine), 'k--', 'LineWidth', 1.5, 'DisplayName', 'Analytisk');
xlabel('t'); ylabel('y(t)');
title('Bakåt Euler för olika n');
legend show; grid on;

