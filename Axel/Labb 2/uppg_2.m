B = 0.1268794;   % 0.05 ≤ B ≤ 0.4

y = @(x) (exp(-B.*x) + 0.6) .* (1 + (x/9).^3);

% Integral 
% pi * från 0 till 26 integral(y^2)dx

% Upphöjt i två för rotationsvolym
f = @(x) (y(x)).^2;

a = 0;
b = 26;

n = [2,4,8,16,32,64,128,256,512,1024,2048];

volymer = zeros(size(n));

for i = 1:length(n)
    h = (b-a)/n(i);
    x = a:h:b;

    trapetsregeln = h * ( 0.5*f(x(1)) + sum(f(x(2:end-1))) + 0.5*f(x(end)) );

    volymer(i) = pi * trapetsregeln;
end

disp(volymer)

%% Felskattning
delta_trunk = abs(diff(volymer(1:length(n))));

kvoter = delta_trunk(1:end-1) ./ delta_trunk(2:end);

disp('Abs skillnader:')
disp(delta_trunk)
disp('Kvoter:')
disp(kvoter)

% Runt 16 steg blir kvoten cirka 4, alltså har man ett 
% rätt säkert svar där, ungefär en decimal.

T8 = volymer(3); % T(h/8)
T16 = volymer(4); % T(h/16)
T32 = volymer(5); % T(h/32)

delta1 = T16 - T8;
delta2 = T32 - T16;

kvot_check = delta1/delta2; % ger typ 4

delta1_ny = delta1 / 3;
delta2_ny = delta2 / 3;

T16_hatt = delta1_ny + T16;
T32_hatt = delta2_ny + T32;

delta_rich = abs(T16_hatt - T32_hatt);

fprintf('Första värdet: %.6f ± %.6f\n', T32, abs(delta2));
fprintf('Bättre rich värde: %.6f ± %.6f\n', T32_hatt, delta_rich);

kvot_felgranser = delta_rich / delta2;

fprintf('Andel i skillnad av felgränserna: %.6f', abs(kvot_felgranser)); % Minskar med 99,4 procentenheter







