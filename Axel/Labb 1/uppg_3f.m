

clear; clc;

% Parametrar
T = 24;                 % slutpunkt för intervallet
n = 320;                % antal delintervall (40, 80, 160, 320)
h = T / n;              % steglängd
t = linspace(0, T, n+1); % noder (inklusive 0 och T)

% Eulers bakåtmetod
f = @(t,y) cos(4*t) - (3/4)*y;
y = zeros(1, n+1);
y(1) = 2;               % begynnelsevillkor y(0)=2

for i = 1:n
    % Bakåt Euler använder t(i+1)
    y(i+1) = (y(i) + h*cos(4*t(i+1))) / (1 + (3*h)/4);
end

y_list = y(:);          % kolumnvektor med alla y-värden

% Jämför med analytisk lösning
analytisk_f = @(t) (518/265)*exp(-(3/4)*t) + ...
                   (12/265)*cos(4*t) + (64/265)*sin(4*t);

fprintf('y(24) enligt bakåt Euler: %.6f\n', y_list(end));
fprintf('y(24) analytisk lösning:  %.6f\n', analytisk_f(T));
fprintf('Fel: %.6e\n', abs(y_list(end) - analytisk_f(T)));

% Plotta resultatet
figure;
plot(t, y_list, 'b-', 'LineWidth', 1.5); hold on;
fplot(analytisk_f, [0 T], 'r--', 'LineWidth', 1.2);
xlabel('t'); ylabel('y(t)');
title(sprintf('Bakåt Euler (n = %d, h = %.4f)', n, h));
legend('Bakåt Euler', 'Analytisk lösning');
grid on;