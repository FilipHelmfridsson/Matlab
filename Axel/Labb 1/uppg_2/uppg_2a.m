xn = 1.94;  % Startvärde nära ett nollställe
target_diff = 5e-10;  % Felgräns enligt uppgiften

diff = Inf;
iteration_amount = 0;

while abs(diff) > target_diff
    fx = nedbojning(xn);             % Funktionsvärde
    dfx = nedbojning_derivata(xn);   % Derivatavärde

    xn_new = xn - (fx / dfx);        % Newtons metod
    diff = xn_new - xn;              % Skillnaden

    xn = xn_new;                     % Uppdatera xn
    iteration_amount = iteration_amount + 1;
end

disp(['Iterations needed: ', num2str(iteration_amount)]);
disp(['Converged value: ', num2str(xn, 15)]);  % Skriv ut med hög precision

% Även om man sätter toleransen till 5e-10 så betyder det inte automatiskt att de 9 första decimalerna i resultatet är korrekta.
% Det krävs att funktionen är välbeteende nära nollstället (dvs. att derivatan inte är nära noll och att funktionen är tillräckligt "slät").