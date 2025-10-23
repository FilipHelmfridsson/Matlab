function [y_list] = framat_euler(t, y, h, n)
    f = @(t,y) cos(4*t) - (3/4)*y;
    for i = 1:n
        y(i+1) = y(i) + h * f(t(i), y(i));
    end
    y_list = y(:);
end