function [a, b, y, x, x_left, x_right] = golden_ratio(f, a, b, acu, step)

%dane testowe
% f = @(x) x.^2;
% a = -5;
% b = 5;
% acu = 0;
% step = 10;

%dane funkcji
step_count = 0;
k = (sqrt(5)-1)/2;

%wyznaczanie przedzia³u unimodalnoœci
uni_acu = (b - a) / 1000;
[a, b] = unimodality_check(f, a, b, uni_acu);

%dane przedzia³ów
x_left = [a];
x_right = [b];

%algorytm liczenia dla dokladnosci
x1 = b - k*(b - a);
x2 = a + k*(b - a);
while (b - a >= 2*acu && acu>0) || (step_count < step && step > 0)
    if f( x1 ) < f( x2 )
        b = x2;
        x2 = x1;
        x1 = b - k*(b - a);
    else
        a = x1;
        x1 = x2;
        x2 = a + k*(b - a);
    end
    x_left(step_count+1) = a;
    x_right(step_count+1) = b;
    step_count = step_count+1;
end
x = [x_left, x_right];
y = f(x);


%algorytm liczenia dla liczby krokow
% if acu == 0 && step > 0
%     x1 = b - k*(b - a);
%     x2 = a + k*(b - a);
%     while 
%         if f( x1 ) < f( x2 )
%             b = x2;
%             x2 = x1;
%             x1 = b - k*(b - a);
%         else
%             a = x1;
%             x1 = x2;
%             x2 = a + k*(b - a);
%         end
%         x_left(step_count+1) = a;
%         x_right(step_count+1) = b;
%         step_count = step_count+1;
%     end
%     x = [x_left, x_right];
%     y = f(x);
% end

