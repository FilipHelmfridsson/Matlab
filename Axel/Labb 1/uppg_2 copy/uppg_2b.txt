xn = 1.25;  % Startvärde nära ett nollställe
target_diff = 5e-10;  % Felgräns enligt uppgiften

diff = Inf;
diff_1 = 0;
k_list = [];
iteration_amount = 0;

while abs(diff) > target_diff
    fx = nedbojning(xn);             % Funktionsvärde
    dfx = nedbojning_derivata(xn);   % Derivatavärde

    xn_new = abs(xn - (fx / dfx));        % Newtons metod
    diff = abs(xn_new - xn);              % Skillnaden

    if iteration_amount > 0  % hoppa över första
        k = diff / diff_1^2;
        k_list(end+1) = k;

%        disp(diff)
%        disp(diff_1^2)
%        disp('---')
    end

    diff_1 = diff;
    xn = xn_new;                     % Uppdatera xn
    iteration_amount = iteration_amount + 1;
end

disp(['Iterations needed: ', num2str(iteration_amount)]);
disp(['Converged value: ', num2str(xn, 15)]);
disp('k_list:');
disp(k_list);

% Plot k_list
figure;
plot(1:length(k_list), k_list, '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteration');
ylabel('Convergence ratio k');
title('Convergence ratios of Newton''s method');
grid on;