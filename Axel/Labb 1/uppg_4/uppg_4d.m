clear; clc;

R = 2;             % cylinderns radie
T = 12;            % sluttid
dt = 0.05;          % tidssteg
N = 200;           % antal punkter i startformationen
center = [-8, 1.2];% centrum för cirkeln
r = 0.8;           % Startcirkels radie
circles_plot = [3, 6, 9, 12];   % tider (sekunder) att visa

% Skapa startformation (regelbunden N-hörning)
vinkel = linspace(0, 2*pi, N+1); vinkel(end) = []; % ta bort sista punkt så vi inte duplicerar
x0 = center(1) + r*cos(vinkel); 
y0 = center(2) + r*sin(vinkel);

% Förbered Euler-integrationen
t = 0:dt:T;
n = length(t);
x = zeros(N, n);
y = zeros(N, n);
x(:,1) = x0(:);     % N punkter
y(:,1) = y0(:);

% Eulers metod - anropa euler_partikel EN gång per steg och få båda utdata
for j = 1:N
    for i = 1:n-1
        [x_next, y_next] = euler_partikel(x(j,i), y(j,i), dt);
        x(j,i+1) = x_next;
        y(j,i+1) = y_next;
    end
end

% Rita deformerade klumpar och beräkna area
figure; hold on;
colors = lines(length(circles_plot));

areas = zeros(1, length(circles_plot));
for k = 1:length(circles_plot)
    % circles_plot innehåller tider (sekunder) där vi vill undersöka formen.
    time_k = circles_plot(k);

    % Konvertera tid -> index i tidsvektorn:
    % idx = round(time / dt) + 1 eftersom t(1) = 0 motsvarar index 1.
    idx = round(time_k / dt) + 1;

    % Hämta alla N punkters positioner vid tidpunkt idx
    xh = x(:, idx);   % kolvektor med x-koordinater vid tid time_k
    yh = y(:, idx);   % kolvektor med y-koordinater vid tid time_k

    % Beräkna arean av polygonen given av (xh,yh).
    % Vi använder circshift med -1 för att multiplicera varje punkt med nästa punkt.
    % Summan ger 2*area (kan bli negativ beroende på orientering) => ta abs och halvera.
    area = 0.5 * abs(sum(xh .* circshift(yh, -1) - yh .* circshift(xh, -1)));
    areas(k) = area;  % spara arean i resultatvektorn

    % Rita den slutna kurvan med area i legend/DisplayName.
    % Lägg till första punkten igen ([xh; xh(1)]) för att stänga polygonen vid plotting.
    fill([xh; xh(1)], [yh; yh(1)], colors(k,:), 'FaceAlpha', 0.3, ...
         'EdgeColor', colors(k,:), 'LineWidth', 1.2, ...
         'DisplayName', sprintf('t = %d s (A = %.4f)', time_k, area));
end

% Rita cylinder
vinkel_cyl = linspace(0, 2*pi, 200);
plot(R*cos(vinkel_cyl), R*sin(vinkel_cyl), 'k', 'LineWidth', 1.5, 'DisplayName', 'Cylinder');

% Snygga till figuren
axis equal; grid on;
xlabel('x'); ylabel('y');
title('Deformation av partikelklump runt cylinder');
legend show;

% Skriv ut areorna i kommandofönstret
fprintf('Areor för deformerade klumpar: \n --- \n');
for k = 1:length(circles_plot)
    fprintf('Efter t = %2d s: A = %.6f\n', circles_plot(k), areas(k));
end


% Felgräns för area-beräkningen (uppgift d)
% Arean blir inte helt exakt, eftersom:
%
% 1. Tidssteget h i Eulers metod är begränsat.
%    - Ju större tidssteg, desto sämre noggrannhet.
%    - Felet växer ungefär linjärt med tidsstegets storlek.
%
% 2. Antalet punkter N i polygonen påverkar.
%    - Fler punkter ger att figuren beskrivs noggrannare 
%      vilket i sin tur leder till ett mindre fel.
%
% 3. Numeriska avrundningsfel kan uppstå när punkterna flyttas mycket
%    eller ligger mycket nära cylindern.
%    - Ex: Om centrum av startcirkeln är på [-8, 0.5]
%
% Praktisk feluppskattning:
%   Om vi kör beräkningen en gång till med halvt tidssteg (h/2).
%   Jämför arean från h och h/2 vid samma tider:
%   Alltså som vi tdigare gjort E_A ≈ |A_{h/2} - A_h|
%   Denna skillnad kan användas som en felgräns.