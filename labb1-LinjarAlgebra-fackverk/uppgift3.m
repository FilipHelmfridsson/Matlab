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

% fördela jämnt över längden xmax
nodavstandxled = xmax / ((N-1)/2); %avstånd mellan noder i x-led
xnod = zeros(N,1); % Skapar en nollmatris för x koordinater
xnod(1:2) = 0; % Första och andra noden vid väggen
for i = 3:N
    xnod(i) = xnod(i-2) + nodavstandxled; % jämna noder på samma x som näst föregående
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



% --- Bars ---Välj Modell ---------------------------------------------
modell=4;


% Modell 1. - Rak
% 1-3---5---7---9 --11--13
%  / \ / \ / \ / \  / \ / \
% 2---4---6---8---10--12--14
%                       \ |
%                        15
% Räknar ut stänger mellan noderna
bars = [];
if modell ==1
    % kräver en annan xnod uppsättning för att bli rätt
    nodavstandxled = xmax / (N-3); %avstånd mellan noder i x-led
    xnod = zeros(N,1); % Skapar en nollmatris för x koordinater
    xnod(1:2) = 0; % Första och andra noden vid väggen
    for i = 3:N
        xnod(i) = xnod(i-1) + nodavstandxled; % jämna noder på samma x som näst föregående
    end
    xnod(N) = xmax; % Sista noden längst ut så inget avrundningsfel blir
    xnod

    ynod = zeros(N,1);
    for i = 1:N-1
        if mod(i,2) ~= 0 % ojämna noder
            ynod(i) = 1;
        else % jämna noder
            ynod(i) = 0.8
        end
    end
    ynod(N) = ysista; %sista noden
    ynod


    for i = 1:N-3
        bars = [bars;i i+2]; % horisontella stänger
        if mod(i,2) == 0 % jämn nod
            bars = [bars;i i+1]; % sneda stänger /
            if i~=1
                bars = [bars;i i-1]; % sneda stänger \
            end
        end
    end
    %missar sista sneda och raka noden lägger till den här:
    bars = [bars;N-1 N];
    bars = [bars;N-1 N-2];
    bars = [bars;N-3 N];
    % Tar bort bar mellan nod 1 och nod 2 (väggen)
    index = find(all(bars == [2 1], 2));
    bars(index, :) = [];

elseif modell ==2
    % Modell 2 - Lutande
    %1---3---5---7---9---11---13 --15
    % \  |\  |\  |\  | \  |\  | \   |
    %  \ | \ | \ | \ |  \ | \ |  \  | 
    %2---4---6---8---10---12--14-- 16
    

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
    % Modell 3 Lutande
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

elseif modell ==4
    % Modell 5 - Rak
    %1---3---5---7---9---11--13---15
    % \  |\  |\  |\  |\   |\  |\  |
    %  \ | \ | \ | \ | \  | \ | \ |
    %2-- 4- -6- -8- -10--12--14---16
    %                          \  |
    %                            17
    nodavstandxled = xmax / ((N-3)/2); %avstånd mellan noder i x-led
    xnod = zeros(N,1); % Skapar en nollmatris för x koordinater
    xnod(1:2) = 0; % Första och andra noden vid väggen
    for i = 3:N-3
        xnod(i) = xnod(i-2) + nodavstandxled; % jämna noder på samma x som näst föregående
    end
    xnod(N-2:N) = xmax; % Sista noden längst ut så inget avrundningsfel blir
    xnod

    ynod = zeros(N,1);
    for i = 1:N-1
        if mod(i,2) ~= 0 % ojämna noder
            ynod(i) = 1;
        else % jämna noder
            ynod(i) = 0.8
        end
    end
    ynod(N) = ysista; %sista noden
    ynod

    bars = [];
    for i = 1:N-3
        bars = [bars;i i+2]; % horisontella stänger
        if mod(i,2) ~= 0 % ojämna node
            bars = [bars;i i+3]; 
            if i < N 
                bars = [bars;i i+1]; % sneda stänger uppåt frammåt
            end
        end
    end
    %missar sista sneda och raka noden lägger till den här:
    bars = [bars;N-2 N-1];
    bars = [bars;N-1 N];
    bars = [bars;N-3 N];
    % Tar bort bar mellan nod 1 och nod 2 (väggen)
    index = find(all(bars == [1 2], 2));
    bars(index, :) = [];


elseif modell ==5
    % Modell 5 - Rak
    %1---3---5---7---9---11--13---15
    %  / | / | / | / |  / |  /|  /|
    % /  |/  |/  |/  | /  | / |/  |
    %2-- 4- -6- -8- -10--12--14---16
    %                          \  |
    %                            17
    nodavstandxled = xmax / ((N-3)/2); %avstånd mellan noder i x-led
    xnod = zeros(N,1); % Skapar en nollmatris för x koordinater
    xnod(1:2) = 0; % Första och andra noden vid väggen
    for i = 3:N-3
        xnod(i) = xnod(i-2) + nodavstandxled; % jämna noder på samma x som näst föregående
    end
    xnod(N-2:N) = xmax; % Sista noden längst ut så inget avrundningsfel blir
    xnod
    
    ynod = zeros(N,1);
    for i = 1:N-1
        if mod(i,2) ~= 0 % ojämna noder
            ynod(i) = 1;
        else % jämna noder
            ynod(i) = 0.8
        end
    end
    ynod(N) = ysista; %sista noden
    ynod

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
    bars = [bars;N-1 N];
    bars = [bars;N-3 N];
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

%------------ Matris för styvhet och längförskjutningar  --------------------------
A = genstiffnmatr(xnod, ynod, bars); % Anrop av hjälpfunktion genstiffnmatr för att få en Matris A

% ---  Kraftvektor b (nedåt last i nod N) ---------------------
N = length(xnod);           % N = antal noder
b = zeros(2*(N-2),1);       % b är kraftvektorn i fria noder b= [Fx1..  Fy1.. FyN]
b(end) = -1;  % nedåtriktad kraft på spetsen

% --- Lös systemet A*z = b ----------------------------------
z = A\b; % Detta ger en lösning för z, där z är vektor med förskjutningar för fria noder


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
title("Fackverk efter deformation färgkodat efter längdförändring modell "+modell)
for k = 1:numBars
    i = bars(k,1); j = bars(k,2);

    if relChange(k) > 0.001        % Stor förlängning → RÖD
        col = [1 0 0];
    elseif relChange(k) > 0.0001    % Liten förlängning → ORANGE
        col = [1 0.5 0];
    elseif relChange(k) > -0.0001   % Nästan oförändrad → BLÅ
        col = [0 0 1];
    else                          % Negativ (tryck) → GRÖN
        col = [0 0.7 0];
    end

    plot([xdef(i) xdef(j)], [ydef(i) ydef(j)], 'Color', col, 'LineWidth', 1);
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

% last b(end) = -1
% modell 1, 30 bars N=17, deformation avstandA = 0.0023
% modell 2, 27 bars, N=15, deformation avstandA = 0.0068
% modell 3, 30 bars, N=17, deformation avstandA = 0.0068
% modell 4, 30 bars, N=17, deformation avstandA = 0.0024
% modell 5, 30 bars, N=17, deformation avstandA = 0.0024