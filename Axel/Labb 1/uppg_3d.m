clear; clc;

% PARAMETRAR
T = 24;
n_values = [40, 80, 160, 320];
f = @(t,y) cos(4*t) - (3/4)*y;
analytisk_f = @(t) (518/265)*exp(-(3/4)*t) + (12/265)*cos(4*t) + (64/265)*sin(4*t);

% Vi beräknar först de numeriska (Eulers) värdena vid t=24
y_T = zeros(size(n_values));
for k = 1:length(n_values)
    n = n_values(k);
    h = T / n;
    t = linspace(0, T, n+1);
    y = zeros(1, n+1);
    y(1) = 2;
    for i = 1:n
        y(i+1) = y(i) + h * f(t(i), y(i));
    end
    y_T(k) = y(end);   % sparar värdet vid slutpunkten
end

% --- (1) Numeriskt skattade felgränser ---
% Dessa togs fram i uppgift (c): skillnaden mellan två Euler-resultat
errors_est = abs(y_T(1:end-1) - y_T(2:end));

% --- (2) Exakta (analytiska) fel ---
y_exact = analytisk_f(T);
errors_exact = abs(y_T - y_exact);

% --- (3) Skriv ut jämförelsetabell ---
fprintf(' h\t\tSkattat fel\t\tAnalytiskt (exakt) fel\n');
fprintf('--------------------------------------------------------\n');
for k = 1:length(n_values)
    h = T / n_values(k);
    if k == 1
        fprintf('%.5f\t   -\t\t\t%.5e\n', h, errors_exact(k));
    else
        fprintf('%.5f\t%.5e\t%.5e\n', h, errors_est(k-1), errors_exact(k));
    end
end

% --- (4) Kommentarer / analys ---
fprintf('\nAnalys:\n');
fprintf('- De skattade felen ligger nära de exakta felen, särskilt för små h.\n');
fprintf('- De exakta felen tenderar att vara något större\n');
fprintf('- Skillnaden mellan skattade och exakta fel minskar när h minskar.\n');
