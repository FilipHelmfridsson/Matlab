x0 = 1.65; % Egentligen 1.95
target_diff = 5e-4;
x = (x0 - 5):(x0 + 5);

diff = Inf;
diff_1 = 0;
k_list = [];
iteration_amount = 0;
k = 0;

while diff > target_diff
    x1 = fixpunktsformeln(x0);
    diff = abs(x1 - x0);
    k = diff/diff_1;

    if k ~= Inf  % skip first iteration
        k = diff / diff_1;
        k_list(end+1) = k;
    end

    x0 = x1;
    diff_1 = diff;
    iteration_amount = iteration_amount + 1;
end

disp(['Iterations needed: ', num2str(iteration_amount)]);
disp(['Converged value: ', num2str(x1)]);
disp('k_list:');
disp(k_list);

% Plot k_list
figure;
plot(1:length(k_list), k_list, '-o', 'LineWidth', 2, 'MarkerSize', 6);
xlabel('Iteration');
ylabel('Convergence ratio k');
title('Convergence ratios of fixed-point iteration');
grid on;
