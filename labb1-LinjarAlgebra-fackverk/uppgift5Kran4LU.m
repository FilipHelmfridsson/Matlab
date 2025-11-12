% --- Lägg till sökvägen --------------------------------
addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk')
% --- Rensa upp -----------------------------------------
clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret
close all   % Stänger alla figurer

load('kran4.mat')
whos
% -------------- LU -faktorisering ------
[L,U, P] = lu(A);

%Matris storlek 2856
N=1430 % 2856/2+2 Antal noder

% skapa en vertikal last
% Låt lasten flytta sig
avstand = [0,0];
timeStart = cputime;
for i = ceil(1429:2856)
    %fprintf('%d\n', i)
    b = zeros(2*(1430-2),1);
    b(i) = -10; % applicera en last på -10 N i y-led på nod i
    y = L\(P*b);
    z = U\y;
    % --- Förskjutningar och ny geometri -------------------------
    xdelta = zeros(1430,1); ydelta = zeros(1430,1);   % Skapar en nollmatris för Δx och Δy
    xdelta(3:N) = z(1:(1430-2));              % Δx för fria noder
    ydelta(3:N) = z((1430-2)+1:end);  
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
time = cputime - timeStart
array = 1:1430;
avstand;

% Plotta förflyttningen av nod N beroende på lastens position
figure; grid on; hold on;
title("Förflyttningen av sista noden beroende på lastens position Uppgift 5 kran 4 LU")
plot(array, avstand, '-o');
xlabel('Lastens position (nodnummer)');
ylabel('Förflyttning av sista noden nodnummer N');

[max, nodMax] = max(avstand(3:end));
[min, nodMin] = min(avstand(3:end));
fprintf('Max förflyttning = %.5f vid nod %d\n', max, array(nodMax));
fprintf('Min förflyttning = %.5f vid nod %d\n', min, array(nodMin));

% time = 27.25 MAC M1
% time = 9.7300 MAC M4

% Jämför utan LU
% time = 545s MAC M1
