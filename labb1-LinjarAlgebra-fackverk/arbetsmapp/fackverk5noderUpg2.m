%=== Fackverk med 5 noder =====

% För att hitta hjälpfunktioner
addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk') 

% --- Rensa upp gammal körning -------------------------------
clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret 
close all   % Stänger alla figurer

% ---  Definiera Nodkoordinater 3 noder ----------------------
% 2 noder vid väggen
xnod = [0; 0; 0.2 ; 0.2; 0.5];     % x-koordinater
ynod = [1; 0.8; 1 ; 0.8; 1]; % nod 3 på samma höjd som nod 2

% --- Bars 2 stänger -----------------------------------------
% 1 - 3
%.  / | \
% 2 - 4 - 5
bars = [1 3; 2 3; 3 4; 3 5; 4 5; 2 4];
% bars = [2 3; 1 4;3 4; 3 5;4 5]  Dessa fungerade inte, då typ tippade systemet

% --- Rita ursprungligt fackverk -----------------------------
figure; 
grid on; 
axis equal; 
hold on;
%fackverksplot(xnod, ynod, bars);    % hjälpfunktion fackverksplot



%------------ Matris för stiffnes (styvhet)  --------------------------
A = genstiffnmatr(xnod, ynod, bars) % Anrop av hjälpfunktion genstiffnmatr för att få en Matris A
% SKAPAR EN MATRIS A MED STORLEK 6X6 FÖR DE 3 FRIA NODERNA 3,4,5 


% ---  Kraftvektor b (nedåt last i nod 3) ---------------------
b = [0;0;0;0;0;-100];    % Kraftvektor för vårt fackverk med 5 noder b= [Fx3;Fx4;Fx5;Fy3;Fy4;Fy5]
% Endast nod 3,4,5 är fria och Fy5 har krafter i y-led nedåt

% --- Lös systemet A*z = b ----------------------------------
% Det linjära ekvationssystemet Az = b kan lösas med backslash-kommandot i Matlab genom att skriva z=A\b.
z = A\b; % Detta ger en lösning för z, där z är vektor med förskjutningar för fria noder
% z = [Δx3;Δx4;Δx5;Δy3;Δy4;Δy5] för vårt fackverk

% ---  Förskjutningar Displacement-------------------------
xDisplacement = zeros(5,1); % Skapar en nollmatris för Δx = [Δx1; Δx2; Δx3]
yDisplacement = zeros(5,1); % Skapar en nollmatris för Δy = [Δy1; Δy2; Δy3]
xDisplacement(3:5) = z(1:3); % Δx3 Δx4 Δx5
yDisplacement(3:5) = z(4:end); % Δy3 Δy4 Δy5

xdef = xnod + xDisplacement;
ydef = ynod + yDisplacement;

% --- Rita deformerad struktur -------------------------------
%fackverksplot(xdef, ydef, bars);
%title('Fackverk före  och efter deformation');

norm([1 2; 3 4])
cond([1 2; 3 4]) % Konditionstalet för matris A
% Ett högt konditionstal indikerar att matrisen är nära 
% singulär och att lösningen kan vara känslig för små förändringar i indata.

A = [1 2; 3 4];
A            % enklast (utan semikolon)
disp(A)      % alternativt
%imagesc(A);            % färglägg efter värden
%axis equal tight;
%colorbar;              % skala till höger
%title('imagesc av A');
%heatmap(A);
%title('heatmap av A');