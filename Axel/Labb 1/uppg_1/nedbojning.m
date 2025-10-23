function [uzx] = nedbojning(x)
    M0 = 1;
    L = 3;
    E = 1;
    I = 1;

    R = M0 / (E * I);

    uzx = (R * (L^2 / 12)) * (32 * (x / L) - 27 * (x / L).^2 - 5 * (x / L).^3 - 9 * sin((pi * x) / L));

end