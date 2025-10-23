L = 3;
target_diff = 5e-10;
x0_list = linspace(0, L, 100);  % Testa 100 startvärden i intervallet
roots_found = [];

for i = 1:length(x0_list)
    xn = x0_list(i);
    diff = Inf;
    iteration_amount = 0;

    while abs(diff) > target_diff && iteration_amount < 100
        fx = nedbojning(xn);
        dfx = nedbojning_derivata(xn);
        
        % Undvik division med noll eller nära noll
        if abs(dfx) < 1e-12
            break
        end

        xn_new = xn - (fx / dfx);
        diff = xn_new - xn;

        xn = xn_new;
        iteration_amount = iteration_amount + 1;
    end

    % Kontrollera om xn redan finns i roots_found
    is_new_root = true;
    for r = roots_found
        if abs(xn - r) < 1e-6
            is_new_root = false;
            break
        end
    end

    if is_new_root && xn >= 0 && xn <= L  % Endast rötter inom intervallet
        roots_found(end+1) = xn;
    end
end

% Skriv ut alla unika nollställen
roots_found = sort(roots_found);
disp('Hittade nollställen för utböjningen:');
disp(roots_found);
