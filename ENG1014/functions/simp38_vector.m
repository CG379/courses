function I = simp38_vector(x,y)
% I = simp38_vector(x,y)
% Written by: ???, ID: ???
% Last modified: ???
% Performs a single simpson's 3/8 rule
%
% INPUTS:
%  - x: independent variable
%  - y: dependent variable
% OUTPUT:
%  - I: integral value

% creating x vector and determining width
h = x(2)-x(1);

%Evaluating integral
I = 3*h/8*(y(1) + 3*sum(y(2:3)) + y(end));