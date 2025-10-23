clear; clc;

R = 2;             % cylinderns radie
T = 12;            % sluttid
h = 0.1;           % tidssteg
N = 200;            % antal punkter i startformationen
center = [-8, 1.2];% centrum för cirkeln
r = 0.8;           % radie för cirkeln

% Skapa startformation (regelbunden N-hörning)
theta = linspace(0, 2*pi, N+1); theta(end) = []; % ta bort sista punkt så vi inte duplicerar
x0 = center(1) + r*cos(theta);
y0 = center(2) + r*sin(theta);

% Rita startformation
figure;
hold on;
xlabel('x'); ylabel('y');
title('Startformation och deformation runt cylinder');
axis equal; grid on;

% Rita cylindern
th = linspace(0, 2*pi, 200);
plot(R*cos(th), R*sin(th), 'k', 'LineWidth', 2);
legend('Startformation', 'Cylinder');

% Förbered Euler-integrationen
t = 0:h:T;
n = length(t);
x = zeros(N, n);
y = zeros(N, n);
x(:,1) = x0(:);     % N punkter
y(:,1) = y0(:);

% Eulers metod - anropa euler_partikel EN gång per steg och få båda utdata
for j = 1:N
    for i = 1:n-1
        [x_next, y_next] = euler_partikel(x(j,i), y(j,i), h);
        x(j,i+1) = x_next;
        y(j,i+1) = y_next;
    end
end

% Rita gruppens form vid några intressanta tidpunkter
t_index = [1, round(n/4), round(n/2), round(3*n/4), n];  % t ≈ 0, 3, 6, 9, 12
colors = lines(length(t_index));

for k = 1:length(t_index)
    idx = t_index(k);
    plot([x(:,idx); x(1,idx)], [y(:,idx); y(1,idx)], ...
         'Color', colors(k,:), 'LineWidth', 1.5);
    text(x(1,idx), y(1,idx), sprintf('t = %.1f', t(idx)), 'Color', colors(k,:), ...
         'FontSize', 9, 'FontWeight', 'bold');
end

legend('Start', 'Cylinder', 't ≈ 0', 't ≈ 3', 't ≈ 6', 't ≈ 9', 't ≈ 12');
hold off;