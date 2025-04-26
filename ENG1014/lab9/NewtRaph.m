function [xi,i] = NewtRaph(f,xi,fd,prec)
% 
% [root,i] = faleProp(f,xi,fd,prec)
% Written by: Campbell Gregor, 33110018
% 
% Last edited: 15/9/22
% Root finding using the Newton-Raphson method
% Inputs: function handle, initial guess, derivative of f, stop criteria
% Outputs: the root, how many iterations
% 

i = 0;


while abs(f(xi)) > prec
    i = i + 1;
    xi = xi - (f(xi)/fd(xi));

end

end

