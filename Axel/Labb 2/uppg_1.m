a = -0.2; 
b = 0; 
n = [2,4,8,16,32,64,128,256]; 

h = (b-a)/n(1);
x = a:h:b;
f = 64 .* exp(-0.3.*(x-3).^2); % vi ser att f minskar i x-värde
p = (x-1).^6; % vi ser att p ökar i y-värde

xx = [x(:); flip(x(:))];
yy = [f(:); flip(p(:))];
fill(xx,yy,'g');

% Visuell inspektion
% a = -0.2
% b = 0
% I = (-0,2 -> 0) integral (p - f) dx

%% Trapetsregeln som rektanglar och trianglar

for j = 1:length(n)

    h = (b-a)/n(j);
    x = a:h:b;
    f = 64 .* exp(-0.3.*(x-3).^2);
    p = (x-1).^6;

    tot_area_1 = 0;
    tot_area_2 = 0;

    for i = 1:n(j)
        area_rektangel = h * min(f(i), f(i+1));
        area_triangel = (h * abs(f(i) - f(i+1))) / 2;

        del_tot_area = area_rektangel + area_triangel;

        tot_area_1 = tot_area_1 + del_tot_area;
    end

    for i = 1:n(j)
        area_rektangel = h * min(p(i), p(i+1));
        area_triangel = (h * abs(p(i) - p(i+1))) / 2;

        del_tot_area = area_rektangel + area_triangel;

        tot_area_2 = tot_area_2 + del_tot_area;
    end

    tot_area = tot_area_1 - tot_area_2;
    disp(tot_area)

end

%% Vanliga trapetsmetoden med medelvärde

% trapets_1 = h * (sum(f)-(f(1)+f(length(f)))/2)
% trapets_2 = h * (sum(p)-(p(1)+p(length(p)))/2)

% svar = trapets_1 - trapets_2
% for i = 1:n
%   T1 = h*(f(i+h)+f(i+h))
% end
% T2 = +h/2*(f(h)+f(end))
% T = T1 + T2