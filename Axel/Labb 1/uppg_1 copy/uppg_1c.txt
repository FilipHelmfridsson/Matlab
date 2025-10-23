% undersok_fixpunkter.m
x = [0, 0.59, 1.95, 3];   % punkter att undersöka

% Anropa funktionerna (vektoriserade)
gx = fixpunktsformeln(x);             % g(x)
dgx = fixpunktsformeln_derivata(x);   % g'(x)
res = gx - x;                         % g(x) - x
stable = abs(dgx) < 1;                % logiskt: true = lokal konvergens

% Presentation
fprintf('   x      g(x)       g(x)-x      g''(x)     |g''(x)|<1\n');
fprintf('--------------------------------------------------------\n');
for k = 1:numel(x)
    fprintf('%5.2f  %9.6f  %9.6f  %9.6f    %4s\n', ...
        x(k), gx(k), res(k), dgx(k), mat2str(stable(k)));
end
