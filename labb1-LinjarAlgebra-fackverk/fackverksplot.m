function fackverksplot(xnod,ynod,bars)

% fackverksplot(xnod,ynod,bars) ritar upp fackverket med noder i
% (xnod,ynod) och stanger mellan nod-index givna i bars.

for k=1:size(bars,1)
    plot(xnod(bars(k,1:2)),ynod(bars(k,1:2)),'b'); 
    hold on
end
axis equal
plot(xnod,ynod,'*')
fill([0;0; -0.1;-0.1],[1.1;-0.1;-0.1;1.1],'g')
%hold off % Vi vill behålla hold on för att kunna rita det deformerade fackverk ovanpå det ursprungligt