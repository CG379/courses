function [root,i] = bisection(f,xl,xu,prec)
% 
% [root,i] = bisection(f,x1,xu,prec)
% Written by: Campbell Gregor, 33110018
% 
% Last edited: 15/9/22
% Root finding using the bisection method
% Inputs: function handle, lower limit, upper limit, stop criteria
% Outputs: the root, how many iterations
% 

% Bound check
if f(xu) * f(xl) > 0
    return
end



xr = (xu + xi)/2;
i = 1;


while abs(f(xr)) > prec

    if f(xu) * f(xr) < 0
        xl = xr;
    else
        xu = xr;
    end
    i = i + 1;
    xr = (xu + xl)/2;
end


root = xr;




