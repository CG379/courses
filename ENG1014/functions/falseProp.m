function [root,i] = falseProp(f,x1,xu,prec)
% 
% [root,i] = faleProp(f,x1,xu,prec)
% Written by: Campbell Gregor, 33110018
% 
% Last edited: 15/9/22
% Root finding using the false proposition method
% Inputs: function handle, lower limit, upper limit, stop criteria
% Outputs: the root, how many iterations
% 

% Bound check
if f(xu) * f(x1) > 0
    return
end



xr = (f(xu) * x1 - f(x1) * xu)/(f(xu) - f(x1));
i = 1;


while abs(f(xr)) > prec
    
    if f(xu) * f(x1) < 0
        x1 = xr;
    else
        xu = xr;
    end
    i = i + 1;
    xr = (f(xu) * x1 - f(x1) * xu)/(f(xu) - f(x1));
end

root = xr;
end
