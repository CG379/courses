function [root,i] = secant(f,xi,xi1,prec)
% 
% [root,i] = faleProp(f,x1,xu,prec)
% Written by: Campbell Gregor, 33110018
% 
% Last edited: 15/9/22
% Root finding using the secant method
% Inputs: function handle, initial guess, initial guess - 1, stop criteria
% Outputs: the root, how many iterations
% 

i = 1;

xi2 = xi - f(xi) * (xi .* xi1)/(f(xi) - f(xi1));

while abs(f(xi2)) > prec
    i = i + 1;
    xi1 = xi;
    xi = xi2;

    xi2 = xi - f(xi) * (xi .* xi1)/(f(xi) - f(xi1));
    
    
end

root = xi2;
end

