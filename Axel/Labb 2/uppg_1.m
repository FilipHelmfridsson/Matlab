a = -0.2; 
b = 0; 
n = [2,4,8,16,32,64,128,256]; 

h = (b-a)/n(1);
x = a:h:b;
f = 64 .* exp(-0.3.*(x-3).^2); % vi ser att f minskar i x-värde
p = (x-1).^6; % vi ser att p ökar i y-värde

xx = [x(:); flip(x(:))];
yy = [f(:); flip(p(:))];
fill(xx,yy,'g');

% Visuell inspektion
% a = -0.2
% b = 0
% I = (-0,2 -> 0) integral (p - f) dx

%% Vanliga trapetsmetoden med medelvärde

areor = [];

for i = 1:length(n)
    h = (b-a)/n(i);
    x = a:h:b;
    f = 64 .* exp(-0.3.*(x-3).^2); % vi ser att f minskar i x-värde, - övre gränsen
    p = (x-1).^6; % vi ser att p ökar i y-värde, vilket ger att det är den undre gränsen
    g = f - p; % Övre minus undre funktionen

    trapetsregel = h * (g(1)/2 + sum(g(2:end-1)) + g(end)/2)
    
    areor = [areor, trapetsregel];
end

%% Feluppskattning med trunkeringsfel och halva steglängden

% Försök med format long
delta_trunk = abs(diff(areor(1:length(n))));
% skillnad = [];
% for i = 1:length(deltas);
%     skillnad(i) = [skillnad, deltas(i)/deltas(i+1)];
% end


kvoter = delta_trunk(1:end-1) ./ delta_trunk(2:end);

disp('Abs skillnader:')
disp(delta_trunk)
disp('Kvoter:')
disp(kvoter)


% Utifrån Ninnis anteckningar är svaret rätt säkert när trunkeringsfelet
% minskar med faktor 4 när steglängden halveras, vi ser detta mellan 2 antal
% och 4 antal steg, vilket ger att 0,35 är ett rätt säkert svar 
% med rätt säkra decimaler

%% Feluppskattning med Richardsons-extrapolation

% rich = delta_trunk(1:2)./3;
% T_h2 = areor(1) + rich(1);
% T_h4 = areor(2) + rich(2);
% delta_rich = abs(T_h2 - T_h4);
% delta_1 = delta_trunk(2);
% T_4 = areor(2);

T1 = areor(1); % T(h)
T2 = areor(2); % T(h/2)
T4 = areor(3); % T(h/4)

delta1 = T2 - T1;
delta2 = T4 - T2;

kvot_check = delta1/delta2; % ger typ 4

delta1 = delta1 / 3;
delta2 = delta2 / 3;

T2_hatt = delta1 + T2;
T4_hatt = delta2 + T4;

delta_rich = abs(T2_hatt - T4_hatt);

fprintf('Bättre rich värde: %.6f ± %.6f\n', T4_hatt, delta_rich);
%fprintf('Orginal värde: %.6f ± %.6f\n', T4, delta_trunk(1,2));

% Svar 1. e) Svaret på integralen med fyra säkra decimaler är 0,3507
% 0,350764 > rätt svar > 0,350758
% 0,35076                0,35076 