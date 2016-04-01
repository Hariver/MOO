function [a, b, y, x, x_left, x_right]=bisection(f, a, b, acu, step)


%dane testowe
% f = @(x) x.^2;
% a = -5;
% b = 5;
% acu = 0;
% step = 10;

%dane funkcji
step_count = 0;


%wyznaczanie przedzia³u unimodalnoœci
uni_acu = (b - a) / 1000;
[a, b] = unimodality_check(f, a, b, uni_acu);

%dane przedzia³ów
x_left = [a];
x_right = [b];


%algorytm dzialania dla dok³adnosci
while (b - a >= 2*acu && acu>0) || (step_count < step && step > 0)
    x1 = a + ( b - a )/4;
    xm = ( a + b ) / 2;
    x2 = b - ( b - a ) / 4;
    if f( x1 ) < f( xm )
        b = xm;
    elseif f( x2 ) < f( xm )
        a = xm;
    else
        a = x1;
        b = x2;
    end
    x_left(step_count+1) = a;
    x_right(step_count+1) = b;
    step_count = step_count+1;
end
x = [x_left, x_right];
y = f(x);

%algorytm dzialania dla liczby kroków
% if acu == 0 && step > 0
%     while step_count <= step
%         x1 = a + ( b - a )/4;
%         xm = ( a + b ) / 2;
%         x2 = b - ( b - a ) / 4;
%         if f( x1 ) < f( xm )
%             b = xm;
%         elseif f( x2 ) < f( xm )
%             a = xm;
%         else
%             a = x1;
%             b = x2;
%         end
%         x_left(step_count+1) = a;
%         x_right(step_count+1) = b;
%         step_count = step_count+1;
%     end
%     x = [x_left, x_right];
%     y = f(x);
% end