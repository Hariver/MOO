function [tab_x, last_x] = congradient(z, b, x_op, achiv, step)

%dane testowe
%z = @(x1,y1) 0.3*x1.^2+0.3*y1.^2+0.2*x1*y1;
%A = [4, 1; 1, 3];
%b = [0.2 ; 0.2];
%x = [3; 4];

%step = 7;
%achiv = 0;

%A matrix
syms x y
A = hessian(z, [x, y]);
A = double(A);
%tablica zwrotu
step_count = 0;
tab_x(:,step_count+1) = x_op;
%CG - algorytm
r = b - A*x_op;
p = r;

%Alfa
alfa = (r'*r) / (r'*A*r);

x_op = x_op + alfa*r;
step_count = step_count + 1;
tab_x(:,step_count+1) = x_op;
x_old = zeros(2,1);

while  (step_count < (step-1) && step > 0) | (x_op ~= x_old & achiv > 0)
    r_old = r;
    r = r - alfa*A*p;
    beta = (r'*r) / (r_old'*r_old);
    p = r + beta*p;
    alfa = (r'*r) / (p'*A*p);
    x_old = x_op;
    x_op = x_op + alfa*p;
    step_count = step_count + 1;
    tab_x(:,step_count+1) = x_op;
end
last_x = x_op;

end

