function A=genstiffnmatr(xnod,ynod,bars)
%Labb 1 SF1694

C=1e4; %Styvhetskonstant

%Assemblering av styvhetsmatrisen A
A=zeros(2*length(xnod),2*length(xnod));
%A=spalloc(2*length(xnod),2*length(xnod),40*length(xnod));
for i=1:length(xnod)
    for j=1:length(xnod)   
        %Kontroll om det finns stang mellan (x_i,y_i) och (x_j,y_j)
        flag=0;
        for k=1:size(bars,1)
            if isequal([i,j],bars(k,:)) || isequal([j,i],bars(k,:))
                flag=1;
            end
        end
        if flag==1   %Om det finns stang mellan (x_i,y_i) och (x_j,y_j)
            S=length(xnod);
            A(i,i)=A(i,i)+K(i,j,0);
            A(i,j)=A(i,j)+L(i,j,0);
            A(i,i+S)=A(i,i+S)+M(i,j,0);
            A(i,j+S)=A(i,j+S)+N(i,j,0);
            A(i+S,i)=A(i+S,i)+K(i,j,1);
            A(i+S,j)=A(i+S,j)+L(i,j,1);
            A(i+S,i+S)=A(i+S,i+S)+M(i,j,1);
            A(i+S,j+S)=A(i+S,j+S)+N(i,j,1);
        end
    end
end

%Tar bort rader och kolumner som motvarar de tva forsta noderna, som sitter
%fast i vaggen:

A=A([3:length(xnod) length(xnod)+3:2*length(xnod)], [3:length(xnod) length(xnod)+3:2*length(xnod)]);


function coeff=K(i,j,dim) %i, j=nodindex. dim=0 motsv x, dim=1 motsv y.
x1=xnod(i);
y1=ynod(i);
x2=xnod(j);
y2=ynod(j);

Len=sqrt((x1-x2)^2+(y1-y2)^2);
if dim==0
    coeff=C/Len^3*(x1-x2)^2;
else
    coeff=C/Len^3*(x1-x2)*(y1-y2);
end
end 

function coeff=L(i,j,dim) %i, j=nodindex. dim=0 motsv x, dim=1 motsv y.
x1=xnod(i);
y1=ynod(i);
x2=xnod(j);
y2=ynod(j);

Len=sqrt((x1-x2)^2+(y1-y2)^2);
if dim==0
    coeff=-C/Len^3*(x1-x2)^2;
else
    coeff=-C/Len^3*(x1-x2)*(y1-y2);
end

end

function coeff=M(i,j,dim) %i, j=nodindex. dim=0 motsv x, dim=1 motsv y.
x1=xnod(i);
y1=ynod(i);
x2=xnod(j);
y2=ynod(j);

Len=sqrt((x1-x2)^2+(y1-y2)^2);
if dim==0
    coeff=C/Len^3*(x1-x2)*(y1-y2);
else
    coeff=C/Len^3*(y1-y2)^2;
end
end

function coeff=N(i,j,dim) %i, j=nodindex. dim=0 motsv x, dim=1 motsv y.
x1=xnod(i);
y1=ynod(i);
x2=xnod(j);
y2=ynod(j);

Len=sqrt((x1-x2)^2+(y1-y2)^2);
if dim==0
    coeff=-C/Len^3*(x1-x2)*(y1-y2);
else
    coeff=-C/Len^3*(y1-y2)^2;
end

end

end

