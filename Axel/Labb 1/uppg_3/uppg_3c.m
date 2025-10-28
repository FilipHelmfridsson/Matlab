clear; clc;

% PARAMETRAR
T = 24;
n_values = [320, 640, 1280];   % Antal delintervall (vi använder successiva n)

% Begynnelsevillkor
y0 = 2;

% För att spara resultat
y_T = zeros(size(n_values));   % Euler-värde vid t = 24 för varje n
h_values = zeros(size(n_values));

% EULER FÖR VARJE n
for k = 1:length(n_values)
    n = n_values(k);
    h = T / n;
    h_values(k) = h;

    t = linspace(0, T, n+1);
    y = zeros(1, n+1);
    y(1) = y0;

    % Anropa framåt Euler
    y = framat_euler(t, y, h, n);

    y_T(k) = y(end);   % sparar värdet vid t=24
end

% NUMERISKT SKATTADE FELGRÄNSER
% Skillnaden mellan två på varandra följande steg (h och h/2)
errors_est = abs(y_T(1:end-1) - y_T(2:end));

% TABELL
fprintf(' h\t\tSkattad felgräns (|y_h - y_h/2|)\n');
fprintf('----------------------------------------------\n');
for k = 2:length(n_values)
    fprintf('%.5f\t%.5e\n', h_values(k), errors_est(k-1));
end

% ANALYS
% Kontrollera om felen minskar regelbundet (ungefär faktor 2)
ratios = errors_est(1:end-1) ./ errors_est(2:end);
regelbunden = all(ratios > 1.8 & ratios < 2.2);

fprintf('\n');
if regelbunden
    fprintf('→ De skattade felgränserna avtar regelbundet (ungefär faktor 2).\n');
else
    fprintf('→ De skattade felgränserna avtar inte helt regelbundet.\n');
end
