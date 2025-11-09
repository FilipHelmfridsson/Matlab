%=== Litet fackverk med N noder =====

% För att hitta hjälpfunktioner
addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk') 

% --- Rensa upp ---------------------------------------------
clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret
close all   % Stänger alla figurer

% -----------------Sätt startvärden -----------
% Ange antal Noder
N = 18; % Måste vara ojämnt antal räkna bort baren som är väggen
% Ange yttersta nodens X värde
ysista = 0.5;
xmax = 1.0;

% ---  Definiera Nodkoordinater -----------------------------------------
% Modell 1
% 1-3---5---7---9 --11--13--15
%  / \ / \ / \ / \  / \ / \ / \ 
% 2---4---6---8---10--12--14--16

% Modell 2
%1---3---5---7---9---11---13
% \  |\  |\  |\  | \  |\  | \
%  \ | \ | \ | \ |  \ | \ |  \   
%2---4---6---8---10---12--14--15

% Modell 3
%1---3---5---7---9
%  / | / | / | / |
% /  |/  |/  |/  |
%2--4--6--8--10--11

% Räkna ut x och y koordinater för noderna 
%variant = "xlikaavstand"; % xi​=((N−3)i−3​)⋅(xmax​​/(N−1)/2)
variant = "xproportionell"; % xi​=xmax⋅((N−3)i−3​)p
%variant = "xexponential" % xi = xmax * (1 - r) / (1 - r^((N-3)/2));


% fördela jämnt över längden xmax
if (variant=="xlikaavstand")
    nodavstandxled = xmax / ((N-1)/2) %avstånd mellan noder i x-led
    xnod = zeros(N,1); % Skapar en nollmatris för x koordinater
    xnod(1:2) = 0; % Första och andra noden vid väggen
    for i = 3:N
        xnod(i) = xnod(i-2) + nodavstandxled; % jämna noder på samma x som näst föregående
    end
 
elseif (variant=="xproportionell")
    p = 0.5;  % < 1 => tätare nära väggen, justera t.ex. 0.3–0.8
    xnod = zeros(N,1); % skapar en nollmatris för x koordinater
    xnod(1:2) = 0; % Första två noderna vid väggen
    for i = 3:N
        xi_rel = (i-2) / ((N-3))   % 0 → 1 mellan första och sista fria nod
        % xnod(i) = xmax * xi_rel^p  % exponentiell fördelning
        val = max(0, 1 - xi_rel);     % skyddar mot negativa pga avrundning
        xnod(i) = xmax * (1 - val^p); % inverterad fördelning tätare vid väggen
    end

elseif (variant=="xexponential")
    r = 0.8;  % förhållande mellan varje steg (<1 => tätare nära väggen)
    xnod = zeros(N,1); % skapar en nollmatris för x koordinater
    xnod(1:2) = 0;

    L = xmax * (1 - r) / (1 - r^((N-3)/2)); % normalisering för att få rätt total längd
    for i = 3:N
        xnod(i) = L * sum(r.^(0:(i-3)));
    end
end

xnod

% behåll y kordinaterna då de inte påverkar lika mycket
% Sista nodens y-koordinat är 0.5
nodavstandyledbaruppe = (1-ysista) / ((N-1)/2)
nodavstandyledbarnere = (0.8-ysista) / ((N-1)/2)
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

% --- Rita ursprungligt fackverk -----------------------------
figure; grid on; axis equal; hold on
title('Fackverk före deformation')
fackverksplot(xnod, ynod, bars); % 'b' blå är default i funktionen fackverksplot

xnodAfore = xnod(end) % xKoordinater för nod A före deformation
ynodAfore = ynod(end) % yKoordinater för nod A före deformation

%------------ Matris för stiffnes (styvhet)  --------------------------
A = genstiffnmatr(xnod, ynod, bars) % Anrop av hjälpfunktion genstiffnmatr för att få en Matris A

% ---  Kraftvektor b (nedåt last i nod 3) ---------------------
N = length(xnod);           % N = antal noder
b = zeros(2*(N-2),1)       % b är kraftvektorn i noden 3 den fria noden b= [Fx;Fy] x resp y led
% Skapar en nollmatris med nollor zeros (2,1) = [0;0]
% N-2 för nod 1 och nod2 är fixerade vid väggen
% b har storlek 2*(N-2) eftersom varje nod har två frihetsgrader
% b betyder kraftvektor för fria noder
b((N-2)+(N-2)) = -10  % Fy3 = -1 (nedåt) = Summan av krafter i y-led dvs b(2) = -1
% kraftvektorn b = [0;-1] för vårt lilla fackverk

% --- Lös systemet A*z = b ----------------------------------
z = A\b; % Detta ger en lösning för z, där z är vektor med förskjutningar för fria noder
% z = [Δx3; Δy3] för vårt lilla fackverk

% --- Förskjutningar och ny geometri -------------------------
xdelta = zeros(N,1); ydelta = zeros(N,1);   % Skapar en nollmatris för Δx och Δy
xdelta(3:N) = z(1:(N-2))              % Δx för fria noder
ydelta(3:N) = z((N-2)+1:end)           % Δy för fria noder

% Nya koordinater efter deformation
xdef = xnod + xdelta
ydef = ynod + ydelta

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
% figure; hold on; axis equal; grid on
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


% --- Rita deformerad struktur -------------------------------
%for k = 1:size(bars,1)
%    i = bars(k,1); j = bars(k,2);
%    plot([xdef(i) xdef(j)], [ydef(i) ydef(j)], 'r', 'LineWidth', 1.5); % 'r' = röd
%end
%title('Fackverk före och efter deformation');



%uppgift3
xnodAefter = xdef(end) % xKoordinater för nod A efter deformation
ynodAefter = ydef(end) % yKoordinater för nod A efter deformation
forskjutningxA = xnodAefter - xnodAfore
forskjutningyA = ynodAefter - ynodAfore
avstandA = sqrt(forskjutningxA^2 + forskjutningyA^2)
