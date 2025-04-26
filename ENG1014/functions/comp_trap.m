function I = comp_trap(f,a,b,n)
% I = comp_trap(f,a,b,n)
% Performs composite trapezoidal rule
%
% INPUTS:
%  - f: function handle of equation 
%  - a: starting integral limit
%  - b: ending integral limit
%  - n: number of points 
% OUTPUT:
%  - I: integral value

h = (b-a)/(n-1);
x = linspace(a,b,n);

%Evaluating integral
I = h/2*(f(a) + 2*sum(f(x(2:end-1))) + f(b));