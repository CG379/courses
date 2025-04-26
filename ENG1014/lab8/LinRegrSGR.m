function [F, V, a0, a1, r2] = LinRegrSGR(x, y, n)
% A, B, gradient, y-int, r^2 value = linreg(x-Values, y-Values,order)
% Written by: Campbell Gregor, 33110018
% 
% Last edited: 9/9/22
% Performs Linear regression y = ax + b on a generalised satuaration growth model
% dataset to output (A*x^n)/(B^n + x^n)
% Inputs: x-Values, y-Value, order of growth
% Outputs: gradient, y-int, r^2 value
xnew = 1./(x.^n);

ynew = 1./y;

[a1,a0,r2] = linreg(xnew,ynew);


F = 1/(a0^(1/n));

V = (a1)^(1/n) * F;


end

