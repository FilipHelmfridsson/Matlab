clear; clc;

% Parametrar
T = 24;                 % slutpunkt för intervallet
n = 320;                % antal delintervall (40, 80, 160, 320)
h = T / n;              % steglängd
t = linspace(0, T, n+1); % noder (inklusive 0 och T)

y = zeros(1, n+1);
y(1) = 2;               % begynnelsevillkor y(0)=2

% Anropa framåt Euler
y_list = framat_euler(t, y, h, n);

% Jämför med analytisk lösning
analytisk_f = @(t) (518/265)*exp(-(3/4)*t) + ...
                   (12/265)*cos(4*t) + (64/265)*sin(4*t);

fprintf('y(24) enligt framåt Euler: %.6f\n', y_list(end));
fprintf('y(24) analytisk lösning:  %.6f\n', analytisk_f(T));
fprintf('Fel: %.6e\n', abs(y_list(end) - analytisk_f(T)));

% Plotta resultatet
figure;
plot(t, y_list, 'r-', 'LineWidth', 1.5); hold on;
fplot(analytisk_f, [0 T], 'k--', 'LineWidth', 1.2);
xlabel('t'); ylabel('y(t)');
title(sprintf('Framåt Euler (n = %d, h = %.4f)', n, h));
legend('Framåt Euler', 'Analytisk lösning');
grid on;