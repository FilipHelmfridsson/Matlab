%% Trapetsregeln som rektanglar och trianglar

format long

tot_area = [];

for j = 1:length(n)

    h = (b-a)/n(j);
    x = a:h:b;
    f = 64 .* exp(-0.3.*(x-3).^2);
    p = (x-1).^6;

    tot_area_1 = 0;
    tot_area_2 = 0;

    % Funktion f
    for i = 1:n(j)
        area_rektangel = h * min(f(i), f(i+1));
        area_triangel = (h * abs(f(i) - f(i+1))) / 2;

        del_tot_area = area_rektangel + area_triangel;

        tot_area_1 = tot_area_1 + del_tot_area;
    end

    % Funktion p
    for i = 1:n(j)
        area_rektangel = h * min(p(i), p(i+1));
        area_triangel = (h * abs(p(i) - p(i+1))) / 2;

        del_tot_area = area_rektangel + area_triangel;

        tot_area_2 = tot_area_2 + del_tot_area;
    end

    tot_area = [tot_area, tot_area_1 - tot_area_2];

    %disp(tot_area)
end