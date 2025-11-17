x = 0:... % ange lampligt intervall
f = ... % vektor med f-vardena for dessa x.
p = ... % vektor med p-vardena for dessa x.
xx = [x(:); flip(x(:))];
yy = [f(:); flip(p(:))];
fill(xx,yy,’g’);

