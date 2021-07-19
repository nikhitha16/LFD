
function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F
      
    case 'F1'
        fobj = @F1;
        lb=-30;
        ub=30;
        dim=50;
      
    case 'F2'
        fobj = @F2;
        lb=-500;
        ub=500;
        dim=50;
        
    case 'F3'
        fobj = @F3;
        lb=-5.12;
        ub=5.12;
        dim=50;
        
    case 'F4'
        fobj = @F4;
        lb=-32;
        ub=32;
        dim=50;

 end
end


% F1 (Rosenbrock)

function o = F5(x)
dim=size(x,2);
o=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
end


% F2 (Schwefel)

function o = F8(x)
o=sum(-x.*sin(sqrt(abs(x))));
end

% F3 (Rastrigin)

function o = F9(x)
dim=size(x,2);
o=sum(x.^2-10*cos(2*pi.*x))+10*dim;
end

% F4 (Ackley)

function o = F10(x)
dim=size(x,2);
o=-20*exp(-.2*sqrt(sum(x.^2)/dim))-exp(sum(cos(2*pi.*x))/dim)+20+exp(1);
end


function o=Ufun(x,a,k,m)
o=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
end

