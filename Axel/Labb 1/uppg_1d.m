% Lista över nollställen att testa
nollstallen = [0, 0.59, 1.95, 3];

% Antal iterationer
N = 9;

for j = 1:length(nollstallen)
    x0 = nollstallen(j);
    fprintf('Startvärde: %f\n', x0);
    
    % Iterera fixpunktmetoden
    for i = 1:N
        x0 = fixpunktsformeln(x0);
        fprintf('Iteration %d: x = %.6f\n', i, x0);
    end
    
    % Kontrollera derivatan vid nollstället
    g_0 = fixpunktsformeln_derivata(nollstallen(j));
    fprintf('Derivatan vid nollstället %.2f: g''(x*) = %.6f\n', nollstallen(j), g_prime);
    
    if abs(g_0) < 1
        fprintf('=> Iterationen förväntas konvergera.\n');
    else
        fprintf('=> Iterationen förväntas divergera.\n');
    end
    
    fprintf('-----------------------------\n');
end