
% Välj ett lagom tätt steg för en jämn kurva
x = 0:0.1:5;        % tabellsteg 0.1

% Definiera funktionen och beräkna funktionsvärdena
f = (x.^3)./20 - 2 - (x.^3).*exp(-x);

% Rita grafen
plot(x, f, 'b-', 'LineWidth', 2)
grid on

% Lägg till rubrik och axelbeteckningar
title('Graf av f(x) = x^3/20 - 2 - x^3 e^{-x}')
xlabel('x')
ylabel('f(x)')

% Förtydliga axlarna (valfritt)
xlim([0 5])
ylim([min(f)-0.5  max(f)+0.5])