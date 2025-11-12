addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk')

clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret
close all   % Stänger alla figurer

n =100; % antal iterationer;

% Kran 1
load('kran1.mat')
%whos % => A Size 250x250 då 127 noder -2 som sitter i väggen * 2 frihetsgrader x och y led
A = sparse(A);
%Skapa en b vektor med rätt storlek
%b = zeros(250,1); %250  A's size är 250x250
b = rand(250,1); %250  A's size är 250x250
size = 250;
time=0;
%LU -faktorisering
[L,U, P] = lu(A);
for i= 1:n
    timeStart = cputime;
    y = L\(P*b);
    z = U\y;
    time = time + (cputime - timeStart);
end
tider = [time/n];
fprintf('Medeltid kran 1 = %.4f s\n', time/n);

% Kran 2
load('kran2.mat')
%whos % => A Size 696x696 då 350 noder -2 som sitter i väggen * 2 frihetsgrader x och y led
A = sparse(A);
%Skapa en b vektor med rätt storlek
%b = zeros(696,1);
b = rand(696,1);
size = [size, 696];
time=0;
%LU -faktorisering
[L,U, P] = lu(A);
for i= 1:n
    timeStart = cputime;
    y = L\(P*b);
    z = U\y;
    time = time + (cputime - timeStart);
end
tider = [tider, time/n];
fprintf('Medeltid kran 2 = %.4f s\n', time/n);

% Kran 3
load('kran3.mat')
%whos % => A Size 2x1502 då 753 noder -2 som sitter i väggen * 2 frihetsgrader x och y led
A = sparse(A);
%Skapa en b vektor med rätt storlek
%b = zeros(1502,1);
b = rand(1502,1);
size = [size, 1502];
time=0;
%LU -faktorisering
[L,U, P] = lu(A);
for i= 1:n
    timeStart = cputime;
    y = L\(P*b);
    z = U\y;
    time = time + (cputime - timeStart);
end
tider = [tider, time/n];
fprintf('Medeltid kran 3 = %.4f s\n', time/n); 

% Kran 4
load('kran4.mat')
%whos % => A Size 2856x2856 då 1430 noder -2 som sitter i väggen * 2 frihetsgrader x och y led
A = sparse(A);  % Glesar ut matrisen
%Skapa en b vektor med rätt storlek
%b = zeros(2856,1); 
b = rand(2856,1);
size = [size, 2856];
time=0; 
%LU -faktorisering
[L,U, P] = lu(A);
for i= 1:n
    timeStart = cputime;
    y = L\(P*b);
    z = U\y;
    time = time + (cputime - timeStart);
end
tider = [tider, time/n];
fprintf('Medeltid kran 4 = %.4f s\n', time/n);

figure;
loglog(size, tider, 'o-', 'LineWidth', 1.5);
xlabel('Antal obekanta');
ylabel('Tidsåtgång [s]');

% Linjen blir ganska rak vilket tyder på att sambandet håller hyfsat bra.
% Lutningen kan uppskattas med hjälp av polyfit:
p = polyfit(log(size), log(tider), 1) % 1 betyder linjär passning
lutning = p(1); % Lutningen är första koefficienten
fprintf('Uppskattad lutning α = %.2f\n', lutning);   
title("CPU-tid för Gausselimination på fackverk av olika storlek Uppgift 6 LU, lutning "+lutning);

% Går inte att få fram någon bra lutning, det går för fort

% Med LU faktoriseringen
%Medeltid kran 1 = 0.0001 s
%Medeltid kran 2 = 0.0002 s
%Medeltid kran 3 = 0.0010 s
%Medeltid kran 4 = 0.0030 s



% Utan LU faktorisering
%Medeltid kran 1 = 0.0003 s
%Medeltid kran 2 = 0.0005 s
%Medeltid kran 3 = 0.0015 s
%Medeltid kran 4 = 0.0030 s

% jämfört med uppgift 4
%Medeltid kran 1 = 0.0072 s
%Medeltid kran 2 = 0.0197 s
%Medeltid kran 3 = 0.0817 s
%Medeltid kran 4 = 0.3793 s