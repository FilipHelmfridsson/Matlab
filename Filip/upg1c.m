
xvals = [0, 0.59, 1.95, 3.0];   
L = 3;

% Derivata g'(x) enligt formeln ovan
xi = xvals./L;
gprime = (1/32) * ( 54*xi + 15*xi.^2 + 9*pi*cos(pi*xi) );

% Visa snyggt
T = table(xvals(:), gprime(:), 'VariableNames', {'x', 'gprim'});
disp(T)