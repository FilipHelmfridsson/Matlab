

xn = 0.3;  % Startvärde nära ett nollställe
target_diff = 5e-10;  % Felgräns enligt uppgiften

diff = Inf;
diff_1 = 0;
iteration_amount = 0;
k_list = [];

while abs(diff) > target_diff
    fx = nedbojningen(xn);             % Funktionsvärde
    dfx = derivatanedbojningen(xn);   % Derivatavärde

    xn_new = xn - (fx / dfx);        % Newtons metod
    diff = xn_new - xn;              % Skillnaden

    if iteration_amount > 0
        k = diff/diff_1.^2;
        diff_1 = diff;
        k_list(end+1) = k;

    end
    
    xn = xn_new;                     % Uppdatera xn
    iteration_amount = iteration_amount + 1;

end
disp(['Iterations needed: ', num2str(iteration_amount)]);
disp(['Converged value: ', num2str(xn, 15)]);  % Skriv ut med hög precision
disp(k_list);

figure;
plot(1: length(k_list), k_list, '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteration');
ylabel('Convergence Ratio (k)');
grid on;