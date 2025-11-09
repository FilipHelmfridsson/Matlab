%=== Litet fackverk med 3 noder =====

% För att hitta hjälpfunktioner
addpath('Matlab/Matlab/labb1-LinjarAlgebra-fackverk') 

% --- Rensa upp gammal körning -------------------------------
clear;      % Tar bort alla gamla variabler
clc;        % Rensar kommandofönstret 
close all   % Stänger alla figurer

% ---  Definiera Nodkoordinater 3 noder ----------------------
% 2 noder vid väggen
xnod = [0; 0; 1]     % x-koordinater
ynod = [1; 0.8; 0.8] % nod 3 på samma höjd som nod 2

% --- Bars 2 stänger -----------------------------------------
% 1 \
% 2 - 3
bars = [1 3; 2 3]      % stång 1–3 (sned) och 2–3 (horisontell)

% --- Rita ursprungligt fackverk -----------------------------
figure; 
grid on; 
axis equal; 
hold on;
fackverksplot(xnod, ynod, bars);    % hjälpfunktion fackverksplot


%------------ Matris för stiffnes (styvhet)  --------------------------
A = genstiffnmatr(xnod, ynod, bars) % Anrop av hjälpfunktion genstiffnmatr för att få en Matris A



% ---  Kraftvektor b (nedåt last i nod 3) ---------------------
b = [0; -10]    % Kraftvektor för vårt lilla fackverk med 3 noder b= [Fx3; Fy3]
                % Endast nod 3 är fri och har krafter i y-led

% --- Lös systemet A*z = b ----------------------------------
% Det linjära ekvationssystemet Az = b kan lösas med backslash-kommandot i Matlab genom att skriva z=A\b.
z = A\b % Detta ger en lösning för z, där z är vektor med förskjutningar för fria noder z = [Δx3; Δy3] för vårt lilla fackverk

% ---  Förskjutningar Displacement-------------------------
xDisplacement = zeros(3,1) % Skapar en nollmatris för Δx = [Δx1; Δx2; Δx3]
yDisplacement = zeros(3,1) % Skapar en nollmatris för Δy = [Δy1; Δy2; Δy3] 
xDisplacement(3) = z(1) % Δx3
yDisplacement(3) = z(2) % Δy3 
 
xdef = xnod + xDisplacement
ydef = ynod + yDisplacement

% --- Rita deformerad struktur -------------------------------
fackverksplot(xdef, ydef, bars);
title('Fackverk före (blå) och efter (röd) deformation');



