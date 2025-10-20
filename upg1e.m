
x0 = 1.94;
targetDiff = 5e-4;

diff = inf;
iterationer = 0;
while diff > targetDiff
    x1 = fixpunktsformeln(x0);
    diff = abs(x1-x0);
    x0 = x1;
    iterationer = iterationer + 1;
end

disp(['Nödvändiga iterationer ', num2str(iterationer)])
disp(['Konvergens värde: ', num2str(x1)]);

