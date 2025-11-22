clear all
close all


%% Uppgift 2 c) Hitta B värde så volym hos vattentorner blir 3500

% volymer - 3500 = 0 sekantmetoden
B0 = 0.05;
B1 = 0.1;
riktigvolym = 3500;

a = 0;
b = 26;
n = [2,4,8,16,32,64,128,256,512,1024,2048];

y = @(x, B) (exp(-B.*x) + 0.6) .* (1 + (x/9).^3);

f = @(x, B) (y(x, B)).^2; % Rotationsvolym


olika_B = zeros(size(n));

for i = 1:length(n)
    h = (b-a)/n(i);
    x = a:h:b;

    trapetsregeln = @(B) h * ( 0.5*f(x(1), B) + sum(f(x(2:end-1), B)) + 0.5*f(x(end), B) );

    rotationsvolym = @(B) pi * trapetsregeln(B) - riktigvolym;

    % Ska lösa rotationsvolym(B) = 0

    tolerans = 0.000001; % 5 deciamlers säkerhet
    B_forst = B0;
    B_gammal = B1;
    B_ny = 0; 
    rot_forst = rotationsvolym(B_forst);
    
    while abs(B_gammal - B_forst) > tolerans
        rot_gammal = rotationsvolym(B_gammal);
        
        B_ny = B_gammal - rot_gammal * (B_gammal - B_forst) / (rot_gammal - rot_forst);
        
        B_forst = B_gammal;
        rot_forst = rot_gammal;
        B_gammal = B_ny;
    end

    B_funnen = B_gammal;
    
    olika_B(i) = B_funnen;
end

% Jämför de två sista värdena (för n=1024 och n=2048)
B_bast = olika_B(end);
B_nast_bast = olika_B(end-1);

% Felskattningen är skillnaden mellan de två sista beräkningarna
% Felskattning av sekantmetoden och trapetsregeln kombinerat
felskattning = abs(B_bast - B_nast_bast);

fprintf('Slutgiltigt Beta-värde: %.10f\n', B_bast)
fprintf('Bästa uppskattning av B (för n=%d): %.10f\n', n(end), B_bast);
fprintf('Felskattning (abs|B_n - B_{n-1}|): %.2e\n', felskattning);