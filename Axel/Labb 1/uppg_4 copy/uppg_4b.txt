clear; clc;

T = 12;
y0 = 0.5:0.25:1.25;
x0 = -6;

% Kör med h och h/2
h = 0.1;
[xh,  yh]  = simulate_particles(h,  x0, y0, T);
[xh2, yh2] = simulate_particles(h/2, x0, y0, T);

% Estimat av trunkeringsfel (ordning p = 1)
ex = 2 * (xh(:,end) - xh2(:,end));
ey = 2 * (yh(:,end) - yh2(:,end));

% Rapportera resultat
fprintf('Trunkeringsfelestimat vid t = %g (från h = %.4f → h/2 = %.4f)\n\n', T, h, h/2);
for j = 1:length(y0)
    fprintf('Partikel %d (y0 = %.2f):  ex = %.3e,  ey = %.3e\n', j, y0(j), ex(j), ey(j));
end

% --- Lokal hjälpfunktion ---
function [x, y] = simulate_particles(h, x0, y0, T)
    n = round(T / h);
    m = length(y0);
    x = zeros(m, n+1);
    y = zeros(m, n+1);
    x(:,1) = x0;
    y(:,1) = y0(:);

    for j = 1:m
        for i = 1:n
            [x(j,i+1), y(j,i+1)] = euler_partikel(x(j,i), y(j,i), h);
        end
    end
end
