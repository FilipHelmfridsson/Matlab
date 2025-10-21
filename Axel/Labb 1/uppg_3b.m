% Parametrar
T = 24;       % slutpunkt för intervallet
n = 320;       % antal delintervall (40, 80, 160, 320)

% Steglängd
h = T / n;

% Noder (inklusive 0 och T)
t = linspace(0, T, n+1);

% Eulers metod
f = @(t,y) cos(4*t)-((3/4)*y);
y = zeros(1, n+1);   % preallocate vector for all steps
y(1) = 2;

for i = 1:n
    y(i+1) = y(i) + h * f(t(i), y(i));

end

y_list = y(:);       % column vector with all stepped y's

disp(y_list(end))

analytisk_f = @(t) (518/265)*exp(-(3/4)*t) + (12/265)*cos(4*t) + (64/265)*sin(4*t);

disp(analytisk_f(T))

plot(t,y_list,'r-')