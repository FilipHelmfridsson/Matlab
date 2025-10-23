% Definiera intervallet
x = 0:0.01:3;

% Plotta funktionen
plot(x, nedbojning(x), 'LineWidth', 2);
xlabel('x');
ylabel('uzx');
title('Nedböjning av balken');
grid on;

% Nollställen hittades: x1 = 0, x2 = 0.59, x3 = 1.95, x4 = 3
