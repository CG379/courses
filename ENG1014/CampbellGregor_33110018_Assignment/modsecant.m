function [root,i] = modsecant(f,xi,mod,prec)
% 
% [root,i] = faleProp(f,x1,xu,prec)
% Written by: Campbell Gregor, 33110018
% 
% Last edited: 15/9/22
% Root finding using the modified secant method
% Inputs: function handle, initial guess, loop modifier, stop criteria
% Outputs: the root, how many iterations
% 

i = 0;


while abs(f(xi)) > prec
    i = i + 1;

    xi = xi - mod*f(xi)/(f(xi + mod)- f(xi)); 
end

root = xi;
end

