addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk')

clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret
close all   % Stänger alla figurer

n =10; % antal iterationer;

% Kran 1

load('kran1.mat')
whos % => A Size 250x250 då 127 noder -2 som sitter i väggen * 2 frihetsgrader x och y led
%Skapa en b vektor med rätt storlek
%b = zeros(250,1); %250  A's size är 250x250 - Skapade nollmatris
b = rand(250,1); %250  A's size är 250x250 Slumpar krafter(värden) i kraft matrisen. 
size = 250;
time=0;
for i= 1:n
    timeStart = cputime;
    z=A\b;
    time = time + (cputime - timeStart);
end
tider = [time/n];
fprintf('Medeltid kran 1 = %.4f s\n', time/n);

% Kran 2
load('kran2.mat')
%whos % => A Size 696x696 då 63 noder -2 som sitter i väggen * 2 frihetsgrader x och y led
%Skapa en b vektor med rätt storlek
%b = zeros(696,1);
b = rand(696,1);
size = [size, 696];
time=0;
for i= 1:n
    timeStart = cputime;
    z=A\b;
    time = time + (cputime - timeStart);
end
tider = [tider, time/n];
fprintf('Medeltid kran 2 = %.4f s\n', time/n);

% Kran 3
load('kran3.mat')
%whos % => A Size 250x250 då 127 noder -2 som sitter i väggen * 2 frihetsgrader x och y led
%Skapa en b vektor med rätt storlek
%b = zeros(1502,1);
b = rand(1502,1);
size = [size, 1502];
time=0;
for i= 1:n
    timeStart = cputime;
    z=A\b;
    time = time + (cputime - timeStart);
end
tider = [tider, time/n];
fprintf('Medeltid kran 3 = %.4f s\n', time/n); 

% Kran 4
load('kran4.mat')
%whos % => A Size 2856x2856 då 1429 noder -2 som sitter i väggen * 2 frihetsgrader x och y led
%Skapa en b vektor med rätt storlek
%b = zeros(2856,1); 
b = rand(2856,1);
size = [size, 2856];
time=0; 
for i= 1:n
    timeStart = cputime;
    z=A\b;
    time = time + (cputime - timeStart);
end
tider = [tider, time/n];
fprintf('Medeltid kran 4 = %.4f s\n', time/n);

figure;
loglog(size, tider, 'o-', 'LineWidth', 1.5);
xlabel('Antal obekanta');
ylabel('Tidsåtgång [s]');

grid on;

size
tider

% Text Från uppgiften:
%Om tidsåtgången lyder potenssambandet T ≈ CN^α, där T är tidsåtgången och N är antalet obekanta 
% och C, α konstanter, så kan plottning i loglog-skala ge exponenten α som lutningen
%av resulterande linjen. Detta följer av att ta logaritmen på båda sidor av potenssambandet, vilket ger
%log T ≈log C+ αlog N.

% Linjen blir ganska rak vilket tyder på att sambandet håller hyfsat bra.
% Lutningen kan uppskattas med hjälp av polyfit (googlat fram)
p = polyfit(log(size), log(tider), 1) % 1 betyder linjär passning
lutning = p(1); % Lutningen är första koefficienten
fprintf('Uppskattad exponent α = %.2f\n', lutning);   
title("CPU-tid för Gausselimination på fackverk av olika storlek Uppgift 4,  lutning α "+lutning);


% Medeltid kran 1 = 0.0100 s
% Medeltid kran 2 = 0.0200 s
% Medeltid kran 3 = 0.0880 s
% Medeltid kran 4 = 0.3730 s
% Lutning α = 1.4872