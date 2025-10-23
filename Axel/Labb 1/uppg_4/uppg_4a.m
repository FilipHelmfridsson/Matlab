x0 = -6;                             % x-värden för de fyra partiklarna (skalär)
y0 = [0.5:0.25:1.25];                % vektor med y-värden för de fyra partiklarna
T = 12;
h = 0.1;
n = round(T / h);                    % antal tidssteg
x = zeros(4, n+1);                   % förallokera x-koordinater
y = zeros(4, n+1);                   % förallokera y-koordinater

% Sätt initialvärden i kolumn 1
x(:,1) = x0;
y(:,1) = y0(:);

for j = 1:length(y0)                 % för varje partikel
    for i = 1:n                      % för varje steg
        [x(j,i+1), y(j,i+1)] = euler_partikel(x(j,i), y(j,i), h);
    end
end

% Rita partikelbanorna
figure;
plot(x.', y.', 'LineWidth', 1.2);   % transponera för att rita varje bana
hold on;
% Rita cylinder för referens
theta = linspace(0,2*pi,200);
plot(2*cos(theta), 2*sin(theta), 'k', 'LineWidth', 1.5);
axis equal; grid on;
xlabel('x'); ylabel('y');
title('Strömlinjer runt cylinder (Euler-metoden)');
legend('y0 = 0.5','y0 = 0.75','y0 = 1.0','y0 = 1.25','Cylinder');