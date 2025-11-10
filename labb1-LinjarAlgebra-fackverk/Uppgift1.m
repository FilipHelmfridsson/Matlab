%=== Litet fackverk med N noder =====

% För att hitta hjälpfunktioner
addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk') 

% --- Rensa upp ---------------------------------------------
clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret
close all   % Stänger alla figurer

% -----------------Sätt startvärden -----------
% Ange antal Noder
N = 11; % Måste vara ojämnt antal räkna bort baren som är väggen
% Ange yttersta nodens X värde
ysista = 0.5;
xmax = 1.0;

% ---  Definiera Nodkoordinater -----------------------------------------
% Räkna ut x och y koordinater för noderna fördela jämnt över längden xmax

nodavstandxled = xmax / ((N-1)/2); %avstånd mellan noder i x-led
xnod = zeros(N,1);
xnod(1:2) = 0; % Första och andra noden vid väggen
for i = 3:N-1
    xnod(i) = xnod(i-2) + nodavstandxled; % jämna noder på samma x som näst föregående
end
xnod(N) = xmax; % Sista noden längst ut så inget avrundningsfel blir
xnod

% Sista nodens y-koordinat är 0.5
nodavstandyledbaruppe = (1-ysista) / ((N-1)/2);
nodavstandyledbarnere = (0.8-ysista) / ((N-1)/2);
ynod = zeros(N,1);
ynod(1) = 1; % Första noden uppe vid väggen
ynod(2) = 0.8; % Andra noden nere vid väggen
for i = 3:N-1
    if mod(i,2) ~= 0 % ojämna noder
        ynod(i) = ynod(i-2)-nodavstandyledbaruppe; % ojämna noder uppe
    else % jämna noder
        ynod(i) = ynod(i-2)-nodavstandyledbarnere;
    end
end
ynod(N) = ysista; % Sista noden längst ut så inget avrundningsfel blir
ynod


% --- Bars ------------------------------------------------
%1---3---5---7---9
%  / | / | / | / | \
% /  |/  |/  |/  |  \
%2-- 4-- 6-- 8--10--11
% Räknar ut stänger mellan noderna
bars = [];
for i = 1:N-2
    bars = [bars;i i+2]; % horisontella stänger
    if mod(i,2) == 0 % jämn nod
        bars = [bars;i i+1]; % sneda stänger uppåt
        if i~=1
            bars = [bars;i i-1]; % vertikal nod uppåt
        end
    end
end
%missar sista sneda och raka noden lägger till den här:
bars = [bars;N-1 N];
bars = [bars;N-1 N-2];
% Tar bort bar mellan nod 1 och nod 2 (väggen)
index = find(all(bars == [2 1], 2));
bars(index, :) = [];
% Skriver ut stängerna
length(bars)
bars

% --- Rita ursprungligt fackverk i blått -----------------------------
figure; grid on; axis equal; hold on
title('Fackverk före deformation')
fackverksplot(xnod, ynod, bars); % 'b' blå är default i funktionen fackverksplot

%------------ Matris för stiffnes (styvhet)  --------------------------
A = genstiffnmatr(xnod, ynod, bars) % Anrop av hjälpfunktion genstiffnmatr för att få en Matris A
size(A)
% ---  Kraftvektor b (nedåt last i nod 3) ---------------------
b = zeros(2*(N-2),1);       % b är kraftvektorn ifrån noden 3 den fria noden b= [Fx3, Fx4....FxN Fy3 Fy4.....FyN] x resp y led
% Skapar en nollmatris med nollor zeros
% N-2 för nod 1 och nod2 är fixerade vid väggen SÅ RÄKNAR BARA MED FRIA NODER
% b har storlek 2*(N-2) eftersom varje nod har två frihetsgrader x och y led
% b betyder kraftvektor för fria noder så den börjar först vid nod 3
b((N-2)+(N-2)) = -1; % Sätter en nedåtriktad kraft i y-led i den sista fria noden

% --- Lös systemet A*z = b  Gauss lösning----------------------------------
z = A\b % Detta ger en lösning för z, där z är vektor med förskjutningar för fria noder
% z = [Δx3; Δy3 ...] för vårt fackverk
size(z)

% --- Förskjutningar och ny geometri -------------------------
xdelta = zeros(N,1); 
ydelta = zeros(N,1);   % Skapar en nollmatris för Δx och Δy med rätt storlek
xdelta(3:N) = z(1:(N-2));              % Δx för fria noder
ydelta(3:N) = z((N-2)+1:end);           % Δy för fria noder

% Nya koordinater efter deformation
xdef = xnod + xdelta
ydef = ynod + ydelta

% --- Rita deformerad struktur -------------------------------
%fackverksplot(xdef, ydef, bars);
for k = 1:size(bars,1)
    i = bars(k,1); j = bars(k,2);
    plot([xdef(i) xdef(j)], [ydef(i) ydef(j)], 'r', 'LineWidth', 1.5); % 'r' = röd
end
plot(xdef(end),ydef(end),'*')
title('Fackverk före och efter deformation');

% För att jämföra med Uppgift 2
KontitionstalNnoderLutande = cond(A) % Konditionstalet för matris A
