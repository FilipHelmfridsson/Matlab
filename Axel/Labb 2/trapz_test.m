a = 0;
b = pi/2;
n = 50;
h = (b - a) / n;

x = a:h:b;
y = cos(x);
t = trapz(x, y)

plot (x, y, '-o')