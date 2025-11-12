%=== Litet fackverk med N noder =====

% För att hitta hjälpfunktionerna
addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk') 

% --- Rensa upp ---------------------------------------------
clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret
close all   % Stänger alla figurer

% -----------------Sätt N startvärde -----------
% Ange antal Noder
N = 17; % Måste vara ojämnt antal räkna bort baren som är väggen

% ---  Definiera Nodkoordinater -----------------------------------------
% Räkna ut x och y koordinater för noderna fördela jämnt över längden xmax
xmax = 1.0; % Yttersta nodens X värde
nodavstandxled = xmax / ((N-1)/2); %avstånd mellan noder i x-led
xnod = zeros(N,1);
xnod(1:2) = 0; % Första och andra noden vid väggen
for i = 3:N-1
    xnod(i) = xnod(i-2) + nodavstandxled; % jämna noder på samma x som näst föregående
end
xnod(N) = xmax; % Sista noden längst ut så inget avrundningsfel blir
xnod


% Räkna ut y koordinater för noderna, de dkiljer på över stängerna och understängerna
ysista = 0.5; % Sista nodens y-koordinat är 0.5
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
%Manuell justering: missar sista sneda och raka noden, lägger till dessa här:
bars = [bars;N-1 N];
bars = [bars;N-1 N-2];
% Tar bort bar mellan nod 1 och nod 2 (väggen) som inte finns men som snurran ovan lägger till
index = find(all(bars == [2 1], 2));
bars(index, :) = [];
% Skriver ut stängerna
AntalBar = length(bars)
bars

% --- Rita ursprungligt fackverk i blått -----------------------------
figure; grid on; axis equal; hold on
fackverksplot(xnod, ynod, bars); % 'b' blå är default i funktionen fackverksplot

%------------ Matris för styvhet  --------------------------
A = genstiffnmatr(xnod, ynod, bars); % Anrop av hjälpfunktion genstiffnmatr för att få en Matris A
AntalFrihetsGrader = size(A)  % Storlek på A, antal frihetsgrader är 2*(N-2) då nod 1 och 2 är fixerade vid väggen

% ---  Kraftvektor b (nedåt last i sista Noden) ---------------------
b = zeros(2*(N-2),1);  % b är kraftvektorn ifrån noden 3 den fria noden b= [Fx3, Fx4....FxN, Fy3, Fy4.....FyN] x resp y led
% N-2 för nod 1 och nod 2 är fixerade vid väggen SÅ RÄKNAR BARA MED FRIA NODER
b(end) = -1; % Sätter en nedåtriktad kraft i y-led i den sista fria noden (FyN)

% --- Lös systemet A*z = b  Gauss lösning----------------------------------
z = A\b; % Detta ger en lösning för z, där z är vektor med förskjutningar för fria noder beroende på kraften den utsätts för

% --- Förskjutningar och ny geometri -------------------------
% Skapar en nollmatris för Δx och Δy med rätt storlek
xdelta = zeros(N,1); 
ydelta = zeros(N,1);   

xdelta(3:N) = z(1:(N-2));              % Δx för fria noder
ydelta(3:N) = z((N-2)+1:end);          % Δy för fria noder

% Nya koordinater för alla noder efter deformationen
xdef = xnod + xdelta
ydef = ynod + ydelta

% --- Rita deformerad struktur -------------------------------
title('Fackverk före och efter deformation Uppgift 1');
fackverksplot(xdef, ydef, bars); % 'r' röd, då blå är default i funktionen fackverksplot



% ----------  För att jämföra med Uppgift 2 ------------------------
KontitionstalNnoderLutande = cond(A) % Konditionstalet för matris A
% 1.5642e+04


%-- uppgift3 -- beräkna förskjutning av nod A
xnodAfore = xnod(end);  % xKoordinater för nod A före deformation
ynodAfore = ynod(end);  % yKoordinater för nod A före deformation
xnodAefter = xdef(end); % xKoordinater för nod A efter deformation
ynodAefter = ydef(end); % yKoordinater för nod A efter deformation
forskjutningxA = xnodAefter - xnodAfore;
forskjutningyA = ynodAefter - ynodAfore;
avstandA = sqrt(forskjutningxA^2 + forskjutningyA^2)