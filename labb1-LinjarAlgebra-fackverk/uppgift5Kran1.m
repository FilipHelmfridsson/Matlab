% --- Lägg till sökvägen --------------------------------
addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk')
% --- Rensa upp -----------------------------------------
clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret
close all   % Stänger alla figurer

load('kran1.mat')
whos


% skapa en vertikal last
% Låt lasten flytta sig från från nod 126 till nod 250 och se förflyttningen
avstand = [0,0];
for i = 126:250
    b = zeros(250,1);
    b(i) = -10; % applicera en last på -10 N i y-led på nod i
    z = A\b;
    % --- Förskjutningar och ny geometri -------------------------
    xdelta = zeros(127,1); ydelta = zeros(127,1);   % Skapar en nollmatris för Δx och Δy
    xdelta(3:127) = z(1:(127-2));              % Δx för fria noder
    ydelta(3:127) = z((127-2)+1:end);  
    xnodAfore = xnod(end); % xKoordinater för nod A före deformation
    ynodAfore = ynod(end); % yKoordinater för nod A före deformation        
    % Nya koordinater efter deformation
    xdef = xnod + xdelta;
    ydef = ynod + ydelta;
    xnodAefter = xdef(end); % xKoordinater för nod A efter deformation
    ynodAefter = ydef(end); % yKoordinater för nod A efter deformation
    forskjutningxA = xnodAefter - xnodAfore;
    forskjutningyA = ynodAefter - ynodAfore;
    avstand = [avstand, sqrt(forskjutningxA^2 + forskjutningyA^2)];
end
array = 1:127;
avstand;
% Plotta förflyttningen av nod 125 beroende på lastens position
figure; grid on; hold on;
title("Förflyttningen av nod 125 beroende på lastens position Uppgift 5 kran 1")
plot(array, avstand, '-o');
xlabel('Lastens position (nodnummer)');
ylabel('Förflyttning av sista noden nodnummer 127');

[max, nodMax] = max(avstand(3:end));
[min, nodMin] = min(avstand(3:end));
fprintf('Max förflyttning = %.5f vid nod %d\n', max, array(nodMax));
fprintf('Min förflyttning = %.5f vid nod %d\n', min, array(nodMin));

% Max förflyttning = 0.00983 vid nod 1
% Min förflyttning = 0.00001 vid nod 102