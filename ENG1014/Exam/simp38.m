function I = simp38(f,a,b)
% I = simp38(f,a,b)
% Written by: ???, ID: ???
% Last modified: ???
% Performs a single simpson's 3/8 rule
%
% INPUTS:
%  - f: function handle of equation 
%  - a: starting integral limit
%  - b: ending integral limit
% OUTPUT:
%  - I: integral value

% creating x vector and determining width
x = linspace(a,b,4);
h = x(2)-x(1);

%Evaluating integral
I = 3*h/8*(f(a) + 3*sum((f(x(2:3)))) + f(b));