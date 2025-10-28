x0 = 1.94; % Egentligen 1.95
target_diff = 5e-4; % 0.0005

diff = Inf;
iteration_amount = 0;

while diff > target_diff
    x1 = fixpunktsformeln(x0);
    diff = abs(x1 - x0);
    x0 = x1;
    iteration_amount = iteration_amount + 1;
end

disp(['Iterations needed: ', num2str(iteration_amount)]);
disp(['Converged value: ', num2str(x1)]);