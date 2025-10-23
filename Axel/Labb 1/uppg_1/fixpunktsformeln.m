function [xn1] = fixpunktsformeln(xn)
    L = 3;
    xn1 = (L/32)*(27*(xn/L).^2 + 5*(xn/L).^3 + 9*sin((pi*xn)/L));
end