function d = fixpunktsformelnDerivata(x)
    L = 3;
    % Förenklat, korrekt uttryck för g'(x)
    d = (27 .* x) ./ (16 .* L) + (15 .* x.^2) ./ (32 .* L.^2) + (9*pi/32) .* cos(pi .* x ./ L);
end