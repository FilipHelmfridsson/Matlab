function [x_next, y_next] = euler_partikel(x_curr, y_curr, h)
    R = 2; % Radie på cylinder

    dfx = 1 - R^2 * ((x_curr^2 - y_curr^2)/(x_curr^2 + y_curr^2)^2);
    dfy = -R^2 * ((2*x_curr*y_curr)/(x_curr^2 + y_curr^2)^2);

    x_next = x_curr + h * dfx;
    y_next = y_curr + h * dfy;
end