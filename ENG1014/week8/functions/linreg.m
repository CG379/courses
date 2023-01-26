function [b,a,r2] = linreg(x,y)
% y-int, gradient, r^2 value = linreg(x-Values, y-Values)
% Written by: Campbell Gregor, 33110018
% 
% Last edited: 9/9/22
% Performs Linear regression on a linear dataset in the form y = ax + b
% Inputs: x-Values, y-Values
% Outputs: y-int, gradient, r^2 value

% A and b values
n = length(x);
Sx = sum(x);
Sy = sum(y);
Sxx = sum(x.*x);
Sxy = sum(x.*y);

a = (n*Sxy - Sx * Sy)/(n*Sxx - Sx^2);

b = mean(y) - a * mean(x);

% r^2 values
St = sum((y-mean(y)).^2);
Sr = sum((y - b - a .* x).^2);
r2 = (St - Sr)/St;

end

