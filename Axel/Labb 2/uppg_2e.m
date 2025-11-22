clear all
close all

%% Uppgift 2e – Hitta beta så att volymen blir 2000

riktigvolym = 2000;

a = 0;
b = pi/0.27;
y0 = 2;

% Diffekv från uppgift 2d
diff_ekv = @(x,y,B) (3/2)*sin(y - 3*x) + B*y;

% Funktion som räknar volymen för ett givet B
function V = volym_for_B(B, a, b, y0)

    % Lös differerntialekvationen
    [x_diff, y_diff] = ode45(@(x,y) (3/2)*sin(y - 3*x) + B*y, [a b], y0);

    % Interpolera till jämnt nät (trapetsregeln kräver detta)
    n = 4096;
    x = linspace(a,b,n+1);
    h = (b-a)/n;

    y_uniform = interp1(x_diff, y_diff, x, 'spline');

    % förbred för rotationsvolym
    f = y_uniform.^2;

    % Trapetsregeln
    trapetsregeln = h*(0.5*f(1) + sum(f(2:end-1)) + 0.5*f(end));

    V = pi * trapetsregeln;
end

% sekantmetoden
B_forst = 0.05;
B_gammal = 0.07;
tolerans = 1e-6;

rot_forst = volym_for_B(B_forst, a, b, y0) - riktigvolym;
rot_gammal = volym_for_B(B_gammal, a, b, y0) - riktigvolym;

while abs(B_gammal - B_forst) > tolerans

    B_ny = B_gammal - rot_gammal * (B_gammal - B_forst) / (rot_gammal - rot_forst);

    B_forst = B_gammal;
    rot_forst = rot_gammal;

    B_gammal = B_ny;
    rot_gammal = volym_for_B(B_gammal, a, b, y0) - riktigvolym;
end

beta = B_gammal;

fprintf("Beta som ger volym 2000 är: %.6f\n", beta);

% Tillförlitlighetsbedömning
% Vi provade beta = 0.060161 i uppg 2d, och fick volymen till ungefär 2000, vilket gör svaret tillförlitligt