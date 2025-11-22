clear all
close all


%% Uppgift 2 d) Hitta volym med givet beta och differentialekvation

B = 0.06054;
y_start = 2;
x_start = 0;
x_slut = pi/0.27;

% y' = ...
diff_ekv = @(x, y) (3/2) * sin(y - 3 * x) + B * y;

% Löser differentialekvationen med inbyggd funktion, eftersom det inte fanns krav på annan
% ger vektorer med x- och y-värden
[x_diff, y_diff] = ode45(diff_ekv, [x_start, x_slut], y_start);

% Beräkna rotationsvolym med trapetsregeln
n = [2,4,8,16,32,64,128,256,512,1024,2048,4096,8192];
volymer = zeros(size(n));
a = x_start;
b = x_slut;

for i = 1:length(n)
    h = (b-a)/n(i);
    x_uniform = a:h:b;

    % Ger y-värden mellan två punkter x- och y-diff med av 'spline'
    y_uniform = interp1(x_diff, y_diff, x_uniform, 'spline');

    volymintegrand = y_uniform.^2;

    trapetsregeln = h * ( 0.5*volymintegrand(1) + sum(volymintegrand(2:end-1)) + 0.5*volymintegrand(end) );

    volymer(i) = pi * trapetsregeln;
end

disp(volymer)

%% Felskattning
disp('Volymer för olika N:')
disp(volymer)

delta_trunk = abs(diff(volymer(1:length(n))));
kvoter = delta_trunk(1:end-1) ./ delta_trunk(2:end);

disp('Abs skillnader:')
disp(delta_trunk)
disp('Kvoter:')
disp(kvoter)

% Efter 32 steg blir volymen med richardson extrapolation tillräckligt säker för att man ska kunna 
% lita ppå två decimaler, då den går mot konvergensordning 2, alltså kvoten blir 4.

T32 = volymer(5); % T(h/32)
T64 = volymer(6); % T(h/64)
T128 = volymer(7); % T(h/128)

delta1 = T64 - T32;
delta2 = T128 - T64;

kvot_check = delta1/delta2; % ger typ 4

delta1_ny = delta1 / 3;
delta2_ny = delta2 / 3;

T64_hatt = delta1_ny + T64;
T128_hatt = delta2_ny + T128;

delta_rich = abs(T64_hatt - T128_hatt);

fprintf('Första värdet: %.6f ± %.6f\n', T128, abs(delta2));
fprintf('Bättre rich värde: %.6f ± %.6f\n', T128_hatt, delta_rich);

kvot_felgranser = delta_rich / delta2;

fprintf('Andel i skillnad av felgränserna: %.6f', abs(kvot_felgranser)); % Minskar med 99,4 procentenheter

% För att garantera minst två säkra decimaler måste det skattade felet (E) i det slutgiltiga värdet vara mindre än 0,005
% vilket det blir med richardson ett steg, från antal steg = 32.


