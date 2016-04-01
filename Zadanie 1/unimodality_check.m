function [a_basic, b] = unimodality_check(f, a, b, step)


%dane testowe
% f = @(x) x.^2;
% a = -6;
% b = 5;
% step = 0.001;

%dane wewnetrzne funkcji
unimodal = 0;
unimodal_count = 0;
a_basic = a;
b_basic = b;

a = a + step;

while unimodal == 0 && a < b_basic
    if(f(a-step) < f(a) && f(a+step) < f(a) || f(a-step) > f(a) && f(a+step) > f(a) )
        unimodal = 1;
    else
        a = a + step;
    end
end

if unimodal == 0
    disp('Nie znaleziono unimodalnosci dla podanego przedzia³u.');
    a_basic=-1;
    b=-1;
elseif unimodal == 1
    b = a + step;
end

%test czy reszta funkcji jest unimodalna
if unimodal == 1
    
    a = b + step;
    unimodal = 0;
    
    while unimodal == 0 && a < b_basic
        if(f(a-step) < f(a) && f(a+step) < f(a) || f(a-step) > f(a) && f(a+step) > f(a) )
            unimodal = 1;
        else
            a = a + step;
        end
    end
    if unimodal == 0
        disp('Caly przedzial jest unimodalny.');
        b = b_basic;
    elseif unimodal == 1
        disp('Przedzia³ podany przez u¿ytkownika nie jest unimodalny.')
    end 
end

