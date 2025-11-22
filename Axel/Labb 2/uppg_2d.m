clear all
close all


%% Uppgift 2 d) Hitta volym med givet beta och differentialekvation

B = 0.07;
y_start = 2;
x_start = 0;
x_slut = pi/0.27;

y = @(x) (exp(-B.*x) + 0.6) .* (1 + (x/9).^3);
% dy_dx = @(x) -B.*exp(-B.*x).*(1 + (x/9).^3) + (exp(-B.*x) + 0.6).*(x.^2 / 243); % derivatan

% y' = ...
diff_ekv = @(x, y) (3/2) * sin(y - 3 * x) + B * y;

% Beräkna rotationsvolym med trapetsregeln

n = [2,4,8,16,32,64,128,256,512,1024,2048];
volymer = zeros(size(n));
a = x_start;
b = x_slut;

for i = 1:length(n)
    h = (b-a)/n(i);
    x = a:h:b;

    % Löser differentialekvationen med inbyggd funktion, eftersom det inte fanns krav på annan
    [x_diff, y_diff] = ode45(diff_ekv, x, y_start);

    volymintegrand = y_diff.^2;

    trapetsregeln = h * ( 0.5*volymintegrand(1) + sum(volymintegrand(2:end-1)) + 0.5*volymintegrand(end) );

    volymer(i) = pi * trapetsregeln;
end

disp(volymer)

