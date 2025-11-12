%Stabiltaste fackverket 

% För att hitta hjälpfunktioner
addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk') 

clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret
close all   % Stänger alla figurer


% Ange antal Noder
N = 17; % Måste vara ojämnt antal räkna bort baren som är väggen


% -Välj Modell 
% Det visade sig att våran lutande kran inte alls är så styv
% Dessa alternativ är bättre men Modell 1 är bäst
modell=1;

bars = [];
xmax = 1.0;
ysista = 0.5;

% Modell 1. - Rak - 30 bars N=17, deformation avstandA = 0.0023
% 1-3---5---7---9 --11--13 --15
%  / \ / \ / \ / \  / \ / \ / \
% 2---4---6---8---10--12--14---16
%                            \ |
%                              17
% Räknar ut stänger mellan noderna
if modell ==1
    % kräver en annan xnod uppsättning för att bli rätt
    nodavstandxled = xmax / (N-3); %avstånd mellan noder i x-led
    xnod = zeros(N,1); % Skapar en nollmatris för x koordinater
    xnod(1:2) = 0; % Första och andra noden vid väggen
    for i = 3:N
        xnod(i) = xnod(i-1) + nodavstandxled; % jämna noder på samma x som näst föregående
    end
    xnod(N) = xmax; % Sista noden längst ut så inget avrundningsfel blir

    ynod = zeros(N,1);
    for i = 1:N-1
        if mod(i,2) ~= 0 % ojämna noder
            ynod(i) = 1;
        else % jämna noder
            ynod(i) = 0.8;
        end
    end
    ynod(N) = ysista; %sista noden

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
end

% Modell 2 - Rak - 30 bars, N=17, deformation avstandA = 0.0024
%1---3---5---7---9---11--13---15
% \  |\  |\  |\  |\   |\  |\  |
%  \ | \ | \ | \ | \  | \ | \ |
%2-- 4- -6- -8- -10--12--14---16
%                          \  |
%                            17
if modell ==2

    nodavstandxled = xmax / ((N-3)/2); %avstånd mellan noder i x-led
    xnod = zeros(N,1); % Skapar en nollmatris för x koordinater
    xnod(1:2) = 0; % Första och andra noden vid väggen
    for i = 3:N-3
        xnod(i) = xnod(i-2) + nodavstandxled; % jämna noder på samma x som näst föregående
    end
    xnod(N-2:N) = xmax; % Sista noden längst ut så inget avrundningsfel blir

    ynod = zeros(N,1);
    for i = 1:N-1
        if mod(i,2) ~= 0 % ojämna noder
            ynod(i) = 1;
        else % jämna noder
            ynod(i) = 0.8;
        end
    end
    ynod(N) = ysista; %sista noden

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
end

% Modell 3 - Rak - 30 bars, N=17, deformation avstandA = 0.0024
%1---3---5---7---9---11--13---15
%  / | / | / | / |  / |  /|  /|
% /  |/  |/  |/  | /  | / |/  |
%2-- 4- -6- -8- -10--12--14---16
%                          \  |
%                            17
if modell == 3

    nodavstandxled = xmax / ((N-3)/2); %avstånd mellan noder i x-led
    xnod = zeros(N,1); % Skapar en nollmatris för x koordinater
    xnod(1:2) = 0; % Första och andra noden vid väggen
    for i = 3:N-3
        xnod(i) = xnod(i-2) + nodavstandxled; % jämna noder på samma x som näst föregående
    end
    xnod(N-2:N) = xmax; % Sista noden längst ut så inget avrundningsfel blir
    
    ynod = zeros(N,1);
    for i = 1:N-1
        if mod(i,2) ~= 0 % ojämna noder
            ynod(i) = 1;
        else % jämna noder
            ynod(i) = 0.8
        end
    end
    ynod(N) = ysista; %sista noden

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
xnod
ynod
AntalBars = length(bars)
bars

% Rita ursprungligt fackverk
figure; grid on; axis equal; hold on
fackverksplot(xnod, ynod, bars); % 

% Matris för styvhet och längförskjutningar
A = genstiffnmatr(xnod, ynod, bars);

%  Kraftvektor b (nedåt last i nod N)
N = length(xnod);           % N = antal noder
b = zeros(2*(N-2),1);       % b är kraftvektorn i fria noder
b(end) = -1;  % nedåtriktad kraft på spetsen


z = A\b; % z är då vektorn med förskjutningar för fria noder


% Förskjutningar och ny geometri
xdelta = zeros(N,1); ydelta = zeros(N,1);   % Skapar en nollmatris för Δx och Δy
xdelta(3:N) = z(1:(N-2));             % Δx för fria noder
ydelta(3:N) = z((N-2)+1:end);           % Δy för fria noder

% Nya koordinater efter deformation
xdef = xnod + xdelta;
ydef = ynod + ydelta;


% Rita färgkodat fackverk 
title("Fackverk före och efter deformation Uppgift 3 Modell "+modell)
fackverksplot(xnod, ynod, bars);

%-- uppgift3 -- beräkna förskjutning av nod A
forskjutningxA = xdef(end) - xnod(end);
forskjutningyA = ydef(end) - ynod(end);
avstandA = sqrt(forskjutningxA^2 + forskjutningyA^2)

KontitionstalNnoderLutande = cond(A) % Konditionstalet för matris A
% 
% last b(end) = -1
% modell 1, 30 bars N=17, cond =  3.2344e+03,  avstandA = 0.0023
% modell 2, 30 bars, N=17, cond = 3.8188e+03,  avstandA = 0.0024
% modell 3, 30 bars, N=17, cond =  3.7958e+03, avstandA = 0.0024
% modell från uppgift 1, 30 bars, N=17, cond = 1.5642e+04, avstandA = 0.0068