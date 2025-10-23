function [y_list] = bakat_euler(t, y, h, n)
    f = @(t,y) cos(4*t) - (3/4)*y;
    for i = 1:n
        y(i+1) = (y(i) + h * f(t(i+1), 0)) / (1 + (3*h)/4);
    end
    y_list = y(:);
end