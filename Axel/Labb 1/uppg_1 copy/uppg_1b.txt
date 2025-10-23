x = 0:0.01:3;
y = fixpunktsformeln(x);

plot(x, y, 'b', 'LineWidth', 2);   % g(x)
hold on
plot(x, x, 'r--', 'LineWidth', 1.5); % y = x
xlabel('x');
ylabel('y');
title('Fixpunkter: skärningspunkter mellan y = g(x) och y = x');
grid on
legend('g(x)','y=x')
