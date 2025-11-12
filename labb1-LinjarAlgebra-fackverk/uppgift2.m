%=== Litet fackverk med N noder Men mer instabilt med lodräta stänger=====

% För att hitta hjälpfunktioner
addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk')

% --- Rensa upp ---------------------------------------------
clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret
close all   % Stänger alla figurer

% -----------------Sätt startvärden -----------
% Ange antal Noder
N = 17; % Måste vara ojämnt antal räkna bort baren som är väggen




% ---  Definiera Nodkoordinater -----------------------------------------
% 1 -- 3 ---5 ---7 ---9 ---11 ---13 ---15
%      |    |    |    |    |     |     |  \
% 2 ---4 ---6 ---8 ---10---12 ---14 ---16 --17
% Instabilt fackverk med bara lodräta stänger för stöttning


xmax = 1.0;
nodavstandxled = xmax / ((N-1)/2) %avstånd mellan noder i x-led
xnod = zeros(N,1);
xnod(1:2) = 0; % Första och andra noden vid väggen
for i = 3:+2:N-1 % start:steg:slut, loopar två och två för att sätta både jämn och ojämn nod
    xnod(i) = xnod(i-2) + nodavstandxled; % jämna noder på samma x som näst föregående
    xnod(i+1) = xnod(i); % ojämna noder på samma x som föregående
end
xnod(N) = xmax; % Sista noden längst ut så inget avrundningsfel blir
xnod

%Räkna ut y koordinater för noderna fördela jämnt över höjden y
ysista = 0.5; % Sista nodens y-koordinat är 0.5
nodavstandyledbaruppe = (1-ysista) / ((N-1)/2)
nodavstandyledbarnere = (0.8-ysista) / ((N-1)/2)
ynod = zeros(N,1);
ynod(1) = 1; % Första noden uppe vid väggen
ynod(2) = 0.8; % Andra noden nere vid väggen
for i = 3:N-1
    if mod(i,2) ~= 0 % ojämna noder
        ynod(i) = ynod(i-2)-nodavstandyledbaruppe; % ojämna noder uppe
    else % jämna noder
        ynod(i) = ynod(i-2)-nodavstandyledbarnere; % jämna noder nere
    end
end
ynod(N) = ysista; % Sista noden längst ut så inget avrundningsfel blir
ynod


% --- Bars ------------------------------------------------
% Räknar ut stänger mellan noderna
bars = [];
for i = 3:N-1
    bars = [bars;i i-2]; % horisontella stänger
    if mod(i,2) == 0 % skillt från dvs jämn nod
        bars = [bars;i i-1]; % sneda stänger uppåt
        if i~=1
            %bars = [bars;i i-1]; % vertikal nod uppåt
        end
    end
end
%missar sista sneda och raka noden lägger till den här:
bars = [bars;N-2 N];
bars = [bars;N-1 N];
% Tar bort bar mellan nod 1 och nod 2 (väggen)
index = find(all(bars == [2 1], 2));
bars(index, :) = [];
% Skriver ut stängerna
AntalBars=length(bars)
bars

% --- Rita ursprungligt fackverk -----------------------------
figure; grid on; axis equal; hold on
fackverksplot(xnod, ynod, bars); % 'b' blå är default i funktionen fackverksplot

%------------ Matris för stiffnes (styvhet)  --------------------------
A = genstiffnmatr(xnod, ynod, bars); % Anrop av hjälpfunktion genstiffnmatr för att få en Matris A

% ---  Kraftvektor b (nedåt last i nod 3) ---------------------
b = zeros(2*(N-2),1);
b(end) = -1; % Klarar ingen last alls utan deformering

% --- Lös systemet A*z = b ----------------------------------
z = A\b;

% --- Förskjutningar och ny geometri -------------------------
% Skapar en nollmatrier för Δx och Δy
xdelta = zeros(N,1); 
ydelta = zeros(N,1);   
xdelta(3:N) = z(1:(N-2))              % Δx för fria noder
ydelta(3:N) = z((N-2)+1:end)           % Δy för fria noder

% Nya koordinater efter deformation
xdef = xnod + xdelta
ydef = ynod + ydelta

% --- Rita deformerad struktur -------------------------------
fackverksplot(xdef, ydef, bars);
title('Fackverk före och efter deformation Uppgift 2');

% Uppgift 2
KontitionstalNnoderLutande = cond(A) % Konditionstalet för matris A
% jättehögt konditionstal för detta fackverk med lodräta stänger  4.5502e+17
% Jämför med Uppgift 1 där konditionstalet var mycket lägre  % 1.5642e+04
