clear; clc;

% PARAMETRAR
T = 24;                              % Sluttid
n_values = [40, 80, 160, 320, 640, 1280, 2560, 5120];       % Antal delintervall
analytisk_f = @(t) (518/265)*exp(-(3/4)*t) + ...
                   (12/265)*cos(4*t) + (64/265)*sin(4*t);  % Analytisk lösning

% BERÄKNA FEL
errors_exact = zeros(size(n_values));

for k = 1:length(n_values)
    n = n_values(k);
    h = T / n;
    t = linspace(0, T, n+1);
    y = zeros(1, n+1);
    y(1) = 2;  % begynnelsevillkor
    
    % Anropa framåt Euler
    y_list = framat_euler(t, y, h, n);
    
    % Exakt fel vid t = T
    y_exact = analytisk_f(T);
    errors_exact(k) = abs(y_list(end) - y_exact);
end

% LOG-LOG PLOT
figure;
loglog(n_values, errors_exact, '-o', 'LineWidth', 1.5, 'MarkerSize', 8);
hold on;

% Referenslinje med lutning 1 (Euler är första ordning)
% Välj punkt för linje: sista punkten som referens
ref_line = errors_exact(end) * (n_values / n_values(end)).^(-1); % lutning -1 i n (fel ~ 1/n)
loglog(n_values, ref_line, '--r', 'LineWidth', 1.2);

hold off;
grid on;
xlabel('Number of steps n');
ylabel('Error at t = 24');
title('Log-Log plot of Numerical Error vs Number of Steps');
legend('Numerical error','Reference slope', 'Location', 'northeast');

% UTSKRIFT AV RESULTAT
fprintf(' n\t\tError at t = 24\n');
fprintf('-------------------------\n');
for k = 1:length(n_values)
    fprintf('%4d\t\t%.5e\n', n_values(k), errors_exact(k));
end
