%=== fackverk med N noder =====

% För att hitta hjälpfunktioner
addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk') 

% --- Rensa upp ---------------------------------------------
clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret
close all   % Stänger alla figurer

% -----------------Sätt startvärden -----------
% Ange antal Noder
N = 17; % Måste vara ojämnt antal räkna bort baren som är väggen
% Ange yttersta nodens X värde
ysista = 0.5;
xmax = 1.0;

% ---  Definiera Nodkoordinater -----------------------------------------

% Räkna ut x och y koordinater för noderna 
variant = "xlikaavstand";
%variant = "xglesare"; 

% fördela jämnt över längden xmax
if (variant=="xlikaavstand")
    nodavstandxled = xmax / ((N-1)/2); %avstånd mellan noder i x-led
    xnod = zeros(N,1); % Skapar en nollmatris för x koordinater
    xnod(1:2) = 0; % Första och andra noden vid väggen
    for i = 3:N
        xnod(i) = xnod(i-2) + nodavstandxled; % jämna noder på samma x som näst föregående
    end
 
elseif (variant=="xgleasare")
    % ===== Tätare noder nära väggen =====
    C = (N-3)/2;           % antal fack (ej inkl spets)
    p = 0.5;               % <1 => tätare nära väggen
    
    t = linspace(0,1,C+2); % +2 så sista värdet är spetsens x
    xcol = xmax * (1 - (1 - t).^p);
    
    xnod = zeros(N,1);
    xnod(1:2) = 0;         % väggen
    
    % fackens vertikalpar (INTE spetsen)
    for k = 2:C+1          % slutar innan sista xcol
        xnod(2 + 2*(k-2) + 1) = xcol(k);   % övre
        xnod(2 + 2*(k-2) + 2) = xcol(k);   % undre
    end
    
    % EN spetsnod längst ut
    xnod(end) = xcol(end); % = xmax
end

xnod(N) = xmax; % Sista noden längst ut så inget avrundningsfel blir
xnod

% behåll y kordinaterna då de inte påverkar lika mycket
% Sista nodens y-koordinat är 0.5
nodavstandyledbaruppe = (1-ysista) / ((N-1)/2);
nodavstandyledbarnere = (0.8-ysista) / ((N-1)/2);
ynod = zeros(N,1);
ynod(1) = 1; % Första noden uppe vid väggen
ynod(2) = 0.8; % Andra noden nere vid väggen
for i = 3:N
    if mod(i,2) ~= 0 % ojämna noder
        ynod(i) = ynod(i-2)-nodavstandyledbaruppe; % ojämna noder uppe
    else % jämna noder
        ynod(i) = ynod(i-2)-nodavstandyledbarnere;
    end
end
ynod

% Proportionellt tätare noder närmare väggen då momentet är högre där 



% --- Bars ------------------------------------------------
modell=3;
% Modell 1.  -   Blev fel se figur
% 1-3---5---7---9 --11--13--15
%  / \ / \ / \ / \  / \ / \ / \
% 2---4---6---8---10--12--14--16
% Räknar ut stänger mellan noderna
bars = [];
if modell ==1
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

elseif modell ==2
    % Modell 2
    %1---3---5---7---9---11---13
    % \  |\  |\  |\  | \  |\  | \
    %  \ | \ | \ | \ |  \ | \ |  \   
    %2---4---6---8---10---12--14--15
    % Räknar ut stänger mellan noderna
    bars = [];
    for i = 1:N-2
        bars = [bars;i i+2]; % horisontella stänger
        if mod(i,2) == 0 %  dvs jämn nod
            bars = [bars;i i-1]; % raka stänger uppåt
            if i >= 4 
                bars = [bars;i i-3]; % sneda stänger uppåt bakåt
            end

        end
    end
    %missar sista sneda och raka noden lägger till den här:
    bars = [bars;N-2 N-1];
    bars = [bars;N-1 N-4];
    bars = [bars;N-2 N];
    bars = [bars;N-1 N];
    % Tar bort bar mellan nod 1 och nod 2 (väggen)
    index = find(all(bars == [2 1], 2));
    bars(index, :) = [];

elseif modell ==3
    % Modell 3
    %1---3---5---7---9
    %  / | / | / | / | \
    % /  |/  |/  |/  |.  \
    %2-- 4- -6- -8- -10--11
    % Räknar ut stänger mellan noderna
    bars = [];
    for i = 1:N-2
        bars = [bars;i i+2]; % horisontella stänger
        if mod(i,2) == 0 %  dvs jämn nod
            bars = [bars;i i-1]; % raka stänger uppåt
            if i >= 2
                bars = [bars;i i+1]; % sneda stänger uppåt frammåt
            end
        end
    end
    %missar sista sneda och raka noden lägger till den här:
    bars = [bars;N-2 N-1];
    bars = [bars;N-1 N];
    % Tar bort bar mellan nod 1 och nod 2 (väggen)
    index = find(all(bars == [2 1], 2));
    bars(index, :) = [];
end

% Skriver ut stängerna
length(bars)
bars

% --- Rita ursprungligt fackverk -----------------------------
figure; grid on; axis equal; hold on
title('Fackverk före deformation')
fackverksplot(xnod, ynod, bars); % 'b' blå är default i funktionen fackverksplot



%------------ Matris för stiffnes (styvhet)  --------------------------
A = genstiffnmatr(xnod, ynod, bars); % Anrop av hjälpfunktion genstiffnmatr för att få en Matris A

A = sparse(genstiffnmatr(xnod, ynod, bars));
fprintf('nnz(A)=%d  sum(A)=%.6g  condest(A)=%.2e\n', nnz(A), full(sum(A(:))), cond(A));


% ---  Kraftvektor b (nedåt last i nod 3) ---------------------
N = length(xnod);           % N = antal noder
b = zeros(2*(N-2),1);       % b är kraftvektorn i noden 3 den fria noden b= [Fx;Fy] x resp y led
% Skapar en nollmatris med nollor zeros (2,1) = [0;0]
% N-2 för nod 1 och nod2 är fixerade vid väggen
% b har storlek 2*(N-2) eftersom varje nod har två frihetsgrader
% b betyder kraftvektor för fria noder
% Hitta noden med största x (spetsen)
[~, idxMaxX] = max(xnod);
% Skapa kraftvektor
b((N-2) + (idxMaxX - 2)) = -10;  % nedåtriktad kraft på spetsen
%b((N-2)+(N-2)) = -10;  % FyN - ( negativt nedåt) = Summan av krafter i y-led 
% kraftvektorn b = [0;-10] för vårt fackverk

% --- Lös systemet A*z = b ----------------------------------
z = A\b; % Detta ger en lösning för z, där z är vektor med förskjutningar för fria noder
% z = [Δx3; Δy3] för vårt lilla fackverk

% --- Förskjutningar och ny geometri -------------------------
xdelta = zeros(N,1); ydelta = zeros(N,1);   % Skapar en nollmatris för Δx och Δy
xdelta(3:N) = z(1:(N-2));             % Δx för fria noder
ydelta(3:N) = z((N-2)+1:end);           % Δy för fria noder

% Nya koordinater efter deformation
xdef = xnod + xdelta;
ydef = ynod + ydelta;

% Se om jag kan färglägga beroende på tryck i fackverkets stänger
% --- Beräkna längdförändring för varje stång ------------------
numBars = size(bars,1);
len0 = zeros(numBars,1);
lendef = zeros(numBars,1);
deltaL = zeros(numBars,1);

for k = 1:numBars
    i = bars(k,1); j = bars(k,2);
    len0(k) = sqrt((xnod(j)-xnod(i))^2 + (ynod(j)-ynod(i))^2);
    lendef(k) = sqrt((xdef(j)-xdef(i))^2 + (ydef(j)-ydef(i))^2);
    deltaL(k) = lendef(k) - len0(k); % positiv = töjning, negativ = tryck
end

% Relativ förändring (för färgskala)
relChange = deltaL ./ len0;

% --- Rita färgkodat fackverk --------------------------------
title('Fackverk efter deformation – färgkodat efter längdförändring')
for k = 1:numBars
    i = bars(k,1); j = bars(k,2);

    if relChange(k) > 1e-3        % Stor förlängning → RÖD
        col = [1 0 0];
    elseif relChange(k) > 1e-4    % Liten förlängning → ORANGE
        col = [1 0.5 0];
    elseif relChange(k) > -1e-4   % Nästan oförändrad → BLÅ
        col = [0 0 1];
    else                          % Negativ (tryck) → GRÖN
        col = [0 0.7 0];
    end

    plot([xdef(i) xdef(j)], [ydef(i) ydef(j)], 'Color', col, 'LineWidth', 2);
end
xlabel('x'); ylabel('y');

%uppgift3
xnod
xdef
xnodAfore = xnod(end) % xKoordinater för nod A före deformation
ynodAfore = ynod(end) % yKoordinater för nod A före deformation
xnodAefter = xdef(end) % xKoordinater för nod A efter deformation
ynodAefter = ydef(end) % yKoordinater för nod A efter deformation
forskjutningxA = xnodAefter - xnodAfore
forskjutningyA = ynodAefter - ynodAfore
avstandA = sqrt(forskjutningxA^2 + forskjutningyA^2)

% last b = -10
% modell 1, 30 bars N=17, avstandA = 0.0680
% modell 1, 26 bars N=15, avstandA = 0.0680
% modell 2, 27 bars, N=15, avstandA = 0.0680
% modell 3, 26 bars, N=15, avstandA =  0.0680

%modell 1 nnz(A)=200  sum(A)=146436  cond(A)=2.76e+04
%modell 2 nnz(A)=200  sum(A)=47133.4  cond(A)=2.76e+04
%modell 3 nnz(A)=200  sum(A)=146436  cond(A)=2.76e+04
% Modell 1 och 3 är lika Modell 2 skiljer något då 
%nnz antal nollvärden i A
%sum summan av alla värden i A
%condest konditionstalet för A